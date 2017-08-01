//
//  BorderButton.swift
//  GradientVC
//
//  Created by Antelis on 01/08/2017.
//  Copyright © 2017 shion. All rights reserved.
//

import UIKit

class BorderButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    override public var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width, height: 48)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        prepareButton()
        
        
    }
    func prepareButton() {
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 3
        self.layer.cornerRadius = frame.size.height/2
        self.backgroundColor = UIColor.clear
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        self.titleLabel?.textColor = UIColor.white
    }
}
