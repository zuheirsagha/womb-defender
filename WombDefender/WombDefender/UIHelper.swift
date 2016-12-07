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
}
