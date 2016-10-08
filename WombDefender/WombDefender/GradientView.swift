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
        
        let innerColor = UIColor(red: 1, green: 77/255, blue: 77/255, alpha: 1).cgColor
        let outerColor = UIColor(red: 60/255, green: 5/255, blue: 5/255, alpha: 1).cgColor
        let colours = [innerColor, outerColor] as CFArray
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
