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
    
    var swipeLength : Int = 10
    var swipePath : UIBezierPath!
    var pointCount : Int = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.isMultipleTouchEnabled = false
        self.backgroundColor = UIColor.clear
        swipePath = UIBezierPath()
        swipePath.lineWidth = 2.0
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
            swipePath?.move(to: p)
            pointCount = pointCount + 1
        }
        SpermBehaviour.collider.addBoundary(withIdentifier: "swipe" as NSCopying , for: swipePath)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        SpermBehaviour.collider.removeBoundary(withIdentifier: "swipe" as NSCopying)
        if pointCount < swipeLength {
            if let touch = touches.first {
                let p = touch.location(in: self)
                swipePath?.addLine(to: p)
                pointCount = pointCount + 1
                setNeedsDisplay()
            }
        }
        SpermBehaviour.collider.addBoundary(withIdentifier: "swipe" as NSCopying , for: swipePath)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        SpermBehaviour.collider.removeBoundary(withIdentifier: "swipe" as NSCopying)
        touchesMoved(touches, with: event)
        pointCount = 0
        SpermBehaviour.collider.addBoundary(withIdentifier: "swipe" as NSCopying , for: swipePath)

    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesEnded(touches, with: event)
        pointCount = 0
        SpermBehaviour.collider.removeBoundary(withIdentifier: "swipe" as NSCopying)
    }

}
