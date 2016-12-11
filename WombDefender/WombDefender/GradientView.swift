//
//  GradientView.swift
//  WombDefender
//
//  Created by Zuheir Chikh Al Sagha on 2016-10-08.
//  Copyright © 2016 Zoko. All rights reserved.
//

import UIKit

class GradientView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        let colours = [UIConstants.Colors.innerColor, UIConstants.Colors.outerColor] as CFArray
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let myGradient = CGGradient(colorsSpace: colorSpace, colors: colours, locations: nil)
        
        let center = CGPoint(x: rect.width/2, y: rect.height/2)
    
        context?.drawRadialGradient(myGradient!,
                                    startCenter: center,
                                    startRadius: 0.0,
                                    endCenter: center,
                                    endRadius: rect.height/2,
                                    options: .drawsAfterEndLocation)
    }
    
}
