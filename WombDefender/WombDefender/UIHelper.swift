//
//  UIHelper.swift
//  WombDefender
//
//  Created by Zuheir Chikh Al Sagha on 2016-12-06.
//  Copyright © 2016 Zoko. All rights reserved.
//

import Foundation
import UIKit

open class UIHelper {
    
    open class func drawWomb(_ width : CGFloat, height : CGFloat) -> [UIView] {
        
        let centerLayerView = UIView(frame: CGRect(x: width/2 - CGFloat(width/6),
                                                   y: height/2 - CGFloat(height/6),
                                                   width: CGFloat(width/6)*2,
                                                   height: CGFloat(width/6)*2))
        centerLayerView.backgroundColor = UIColor.white
        centerLayerView.layer.cornerRadius = centerLayerView.frame.size.width/2
        centerLayerView.center = CGPoint(x: width/2, y: height/2)

        let secondLayerView = UIView(frame: CGRect(x: width/2 - CGFloat(width/5),
                                                   y: height/2 - CGFloat(width/5),
                                                   width: CGFloat(width/5)*2,
                                                   height: CGFloat(width/5)*2))
        secondLayerView.center = CGPoint(x: width/2, y: height/2)
        secondLayerView.backgroundColor = UIColor.white
        secondLayerView.alpha = 0.2
        secondLayerView.layer.cornerRadius = secondLayerView.frame.size.width/2
        
        let thirdLayerView = UIView(frame: CGRect(x: width/2 - CGFloat(width/4.25),
                                                  y: height/2 - CGFloat(width/4.25),
                                                  width: CGFloat(width/4.25)*2,
                                                  height: CGFloat(width/4.25)*2))
        thirdLayerView.center = CGPoint(x: width/2, y: height/2)
        thirdLayerView.backgroundColor = UIColor.white
        thirdLayerView.alpha = 0.2
        thirdLayerView.layer.cornerRadius = thirdLayerView.frame.size.width/2
        
        return [centerLayerView, secondLayerView, thirdLayerView]
    }
}
