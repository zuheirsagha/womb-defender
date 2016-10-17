//
//  SpermBehaviour.swift
//  WombDefender
//
//  Created by Zuheir Chikh Al Sagha on 2016-10-06.
//  Copyright © 2016 Zoko. All rights reserved.
//

import UIKit

class SpermBehaviour: UIDynamicBehavior {
    
    private var gravity: UIGravityBehavior!
    
    // Changed these to stack because it is only ever gravity that changes (direction)
    // Therefore avoid creating a bunch of new objects for no reason
    static let collider: UICollisionBehavior = {
        let collider = UICollisionBehavior()
        collider.translatesReferenceBoundsIntoBoundary = true
        return collider
    }()
    
    static let elasticityBehaviour : UIDynamicItemBehavior = {
       let dib = UIDynamicItemBehavior()
        // Used for megasperm -> experiment with elasticity so that it doesnt go too far
        // after bouncing off sheild
        dib.elasticity = 1
        return dib
    }()
    
    init(x: CGFloat, y: CGFloat, centreX: CGFloat, centreY: CGFloat) {
        super.init()
        createGravityBehavior(x: x, y: y, centreX: centreX, centreY: centreY)
        addChildBehavior(gravity)
        addChildBehavior(SpermBehaviour.collider)
        addChildBehavior(SpermBehaviour.elasticityBehaviour)
    }
    
    func addItem(item : UIDynamicItem) {
        gravity.addItem(item)
        SpermBehaviour.collider.addItem(item)
        SpermBehaviour.elasticityBehaviour.addItem(item)
    }
    
    func removeItem(item : UIDynamicItem) {
        gravity.removeItem(item)
        SpermBehaviour.collider.removeItem(item)
        SpermBehaviour.elasticityBehaviour.removeItem(item)
    }

    func createGravityBehavior(x: CGFloat, y: CGFloat, centreX: CGFloat, centreY: CGFloat) {
        gravity = UIGravityBehavior()
        gravity.magnitude = 0.05
        let absX = abs(x-centreX)
        let absY = abs(y-centreY)
        
        if (x >= centreX) {
            if (y >= centreY) {
                gravity.angle = CGFloat(M_PI) + atan(absY/absX)
            } else {
                gravity.angle = CGFloat(M_PI) - atan(absY/absX)
            }
        } else {
            if (y >= centreY) {
                gravity.angle = CGFloat(2*M_PI) - atan(absY/absX)
            } else {
                gravity.angle = atan(absY/absX)
            }
        }
    }
}
