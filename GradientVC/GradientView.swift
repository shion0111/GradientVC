//
//  GradientView.swift
//  GradientVC
//
//  Created by Antelis on
//  Copyright © 2017 shion. All rights reserved.
//

import UIKit

class GradientView: UIView, CAAnimationDelegate {
    
    //  customizable properties : gradient colors, gradient angle, animation duration
    @objc @IBInspectable private var IBColor1: UIColor?
    @objc @IBInspectable private var IBColor2: UIColor?
    @objc @IBInspectable private var Angle: Double = 25
    @objc @IBInspectable private var LoopDuration : Double = 0.8
    
    
    fileprivate var division : CGFloat = 9
    fileprivate var gradient : CAGradientLayer?;
    fileprivate var currentGradient: Int = 0
    fileprivate var colors: [UIColor] = []
    
    
    convenience init(frame: CGRect, hexColor1: String, hexColor2: String, angle: Double) {
        
        self.init(frame: frame)
        IBColor1 = UIColor.getColorWithHex(hexColor1)
        IBColor2 = UIColor.getColorWithHex(hexColor2)
        self.Angle = angle
        
    }
    
    public func start() {
        
        if gradient == nil {
            setup()
        } else {
            gradient?.removeAllAnimations()
        }
        animateLayer()
    }
    
    public func stop() {
        gradient?.removeAllAnimations()
        gradient?.removeFromSuperlayer()
        gradient = nil
    }
    
    //  setup CAGradientLayer, and colors //
    fileprivate func setup(){
        
        calcColors()
        gradient = CAGradientLayer()
        
        gradient?.frame = self.frame
        gradient?.drawsAsynchronously = true
        layer.insertSublayer(gradient!, at: 0)
        gradient?.colors = currentGradientSet()
        
        let x: Double! = Angle / 360.0
        let a = pow(sinf(Float(2.0 * .pi * ((x + 0.75) / 2.0))),2.0);
        let b = pow(sinf(Float(2*Double.pi*((x+0.0)/2))),2);
        let c = pow(sinf(Float(2*Double.pi*((x+0.25)/2))),2);
        let d = pow(sinf(Float(2*Double.pi*((x+0.5)/2))),2);
        
        gradient?.endPoint = CGPoint(x: CGFloat(c),y: CGFloat(d))
        gradient?.startPoint = CGPoint(x: CGFloat(a),y:CGFloat(b))
        
        
    }
    //  divide two colors into [division] parts
    fileprivate func calcColors() {
        colors.removeAll()
        
        var fRed1 : CGFloat = 0
        var fGreen1 : CGFloat = 0
        var fBlue1 : CGFloat = 0
        var fAlpha1: CGFloat = 0
        IBColor1!.getRed(&fRed1, green: &fGreen1, blue: &fBlue1, alpha: &fAlpha1)
        
        var fRed2 : CGFloat = 0
        var fGreen2 : CGFloat = 0
        var fBlue2 : CGFloat = 0
        var fAlpha2: CGFloat = 0
        IBColor2!.getRed(&fRed2, green: &fGreen2, blue: &fBlue2, alpha: &fAlpha2)
        
        var ii : CGFloat = division/2
        
        for _ in (0..<Int(division)) {
            
            colors.append(UIColor(red: ii*(fRed2-fRed1)/division+fRed1, green: ii*(fGreen2-fGreen1)/division+fGreen1, blue: ii*(fBlue2-fBlue1)/division+fBlue1, alpha: 1.0))
            ii += 1
            ii = ii.truncatingRemainder(dividingBy: division)
        }
        
    }
    // setup animation
    fileprivate func animateLayer() {
        currentGradient += 1
        let animation = CABasicAnimation(keyPath: "colors")
        animation.duration = LoopDuration
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        
        animation.toValue = currentGradientSet()
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.delegate = self
        
        self.gradient?.add(animation, forKey:"animateGradient")
    }
    
    fileprivate func currentGradientSet() -> [CGColor] {
        guard colors.count > 0 else { return [] }
        return [colors[currentGradient % colors.count].cgColor,
                colors[(currentGradient + 1) % colors.count].cgColor]
    }
    
    //  forward to next group of colors
    func animationDidStop(_ anim: CAAnimation, finished: Bool) {
        if finished {
            gradient?.colors = currentGradientSet()
            animateLayer()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if gradient == nil {
            setup()
            animateLayer()
        }
        
        gradient?.frame = self.bounds
        gradient?.setNeedsDisplay()
    }
    override func removeFromSuperview() {
        
        super.removeFromSuperview()
        stop()
        
    }
    
}

//  get UIColor from HEXString //
extension UIColor {
    
    class func getColorWithHex(_ hex: String) -> UIColor {
        let scanner: Scanner = Scanner(string: hex)
        // ignore "#"
        if hex.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        
        var rgbValue : UInt32 = 0
        if scanner.scanHexInt32(&rgbValue) {
        
            return UIColor(red: CGFloat(((rgbValue & 0xFF0000) >> 16))/255.0, green: CGFloat(((rgbValue & 0x00FF00) >> 16))/255.0, blue: CGFloat(((rgbValue & 0x0000FF) >> 16))/255.0, alpha: 1.0)
        }
        //  if failed
        return UIColor.white
    }
    
}
