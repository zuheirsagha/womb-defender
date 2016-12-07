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
    
    open class func resizeEgg(_ makeLarger : Bool, centerLayer : UIView, secondLayer : UIView, thirdLayer : UIView) {
        if makeLarger {
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                centerLayer.transform = CGAffineTransform(scaleX: 2, y: 2.5)
                centerLayer.layer.cornerRadius = 0
                
                secondLayer.transform = CGAffineTransform(scaleX: 1.8, y: 2.25)
                secondLayer.layer.cornerRadius = 0
                
                thirdLayer.transform = CGAffineTransform(scaleX: 1.62, y: 2.03)
                thirdLayer.layer.cornerRadius = 0
                thirdLayer.isHidden = true
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                
                centerLayer.transform = CGAffineTransform(scaleX: 1, y: 1)
                centerLayer.layer.cornerRadius = centerLayer.frame.size.width/2

                secondLayer.transform = CGAffineTransform(scaleX: 1, y: 1)
                secondLayer.layer.cornerRadius = secondLayer.frame.size.width/2

                thirdLayer.transform = CGAffineTransform(scaleX: 1, y: 1)
                thirdLayer.layer.cornerRadius = thirdLayer.frame.size.width/2
                thirdLayer.isHidden = false
            })
        }
    }
    
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
