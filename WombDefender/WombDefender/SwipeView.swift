//
//  SwipeView.swift
//  WombDefender
//
//  Created by Zuheir Chikh Al Sagha on 2016-11-29.
//  Copyright © 2016 Zoko. All rights reserved.
//

import Foundation
import UIKit

class SwipeView : UIView {
    
    var swipeLength : CGFloat = 100.0
    var swipePath : UIBezierPath!
    var firstPoint : CGPoint!
    var currentPoint : CGPoint!
    
    var radius : Double!
    var startAngle : CGFloat!
    var _firstTime : Bool = true
    var _direction : Bool = true
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.isMultipleTouchEnabled = false
        self.backgroundColor = UIColor.clear
        swipePath = UIBezierPath()
    }
    
    override func draw(_ rect: CGRect) {
        UIColor.white.setStroke()
        swipePath.stroke()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        SpermBehaviour.collider.removeBoundary(withIdentifier: "swipe" as NSCopying)
        swipePath.removeAllPoints()
        if let touch = touches.first {
            let p = touch.location(in: self)
            firstPoint = p
        }
        
        radius = sqrt(Double(pow(self.center.x-firstPoint.x,2) + pow(self.center.y-firstPoint.y,2)))
        startAngle = atan2(firstPoint.y - self.center.y, self.center.x-firstPoint.y)
        
        SpermBehaviour.collider.addBoundary(withIdentifier: "swipe" as NSCopying , for: swipePath)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if _firstTime || sqrt(pow(swipePath.currentPoint.x-firstPoint.x,2) + pow(swipePath.currentPoint.y-firstPoint.y,2)) < swipeLength {
            _firstTime = false
            if let touch = touches.first {
                let p = touch.location(in: self)
                currentPoint = p
                
                if currentPoint.y > self.center.y && currentPoint.x < self.center.x {
                    _direction = true
                } else if currentPoint.y > self.center.y && currentPoint.x > self.center.x {
                    _direction = true
                } else if currentPoint.y < self.center.y && currentPoint.x < self.center.x {
                    _direction = true
                } else if currentPoint.y < self.center.y && currentPoint.x > self.center.x {
                    _direction = false
                } else {
                    _direction = false
                }
                
                let endAngle = atan2(currentPoint.y - self.center.y, self.center.x-currentPoint.y)
                swipePath = UIBezierPath(arcCenter: self.center, radius: CGFloat(radius!), startAngle: startAngle, endAngle: endAngle, clockwise: _direction)
                setNeedsDisplay()
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesMoved(touches, with: event)
        _firstTime = true
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesEnded(touches, with: event)
        SpermBehaviour.collider.removeBoundary(withIdentifier: "swipe" as NSCopying)
        _firstTime = true
    }

}
