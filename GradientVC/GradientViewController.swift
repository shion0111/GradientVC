//
//  GradientViewController.swift
//  GradientVC
//
//  Created by Antelis
//  Copyright © 2017 shion. All rights reserved.
//

import UIKit

class GradientViewController: UIViewController {

    private var gradient : GradientView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if gradient == nil {
            gradient = GradientView(frame: self.view.bounds, hexColor1: "#F298e7", hexColor2: "#a5f9f9", angle: 25.0)
            view.addSubview(gradient)
            view.sendSubview(toBack: gradient)
            gradient.isUserInteractionEnabled = false
        } else {
            gradient.start()
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if gradient != nil {
            gradient.stop()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

