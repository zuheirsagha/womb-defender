//
//  SpermBehaviour.swift
//  WombDefender
//
//  Created by Zuheir Chikh Al Sagha on 2016-10-06.
//  Copyright © 2016 Zoko. All rights reserved.
//

import UIKit

class SpermBehaviour: UIDynamicBehavior {
    
    private var gravity: UIFieldBehavior!
    
    init(centreX: CGFloat, centreY: CGFloat) {
        super.init()
        gravity = UIFieldBehavior.radialGravityField(position: CGPoint(x: centreX, y: centreY))
        gravity.falloff = 0.1
        
        addChildBehavior(gravity)
        addChildBehavior(SpermBehaviour.collider)
        addChildBehavior(SpermBehaviour.objectBehaviour)
    }
    
    // Changed these to stack because it is only ever gravity that changes (direction)
    // Therefore avoid creating a bunch of new objects for no reason
    static let collider: UICollisionBehavior = {
        let collider = UICollisionBehavior()
        let boundaryInsets = UIEdgeInsetsMake(-50, -50, -50, -50)
        collider.setTranslatesReferenceBoundsIntoBoundary(with: boundaryInsets)
        
        return collider
    }()
    
    static let objectBehaviour : UIDynamicItemBehavior = {
       let dib = UIDynamicItemBehavior()
        // Used for megasperm -> experiment with elasticity so that it doesnt go too far
        // after bouncing off sheild
        dib.elasticity = 1
        dib.allowsRotation = false
        return dib
    }()
    
    func addItem(item : UIDynamicItem) {
        gravity.addItem(item)
        SpermBehaviour.collider.addItem(item)
        SpermBehaviour.objectBehaviour.addItem(item)
    }
    
    func removeItem(item : UIDynamicItem) {
        gravity.removeItem(item)
        SpermBehaviour.collider.removeItem(item)
        SpermBehaviour.objectBehaviour.removeItem(item)
    }
    
    func setFieldStrength(strength: Double) {
        gravity.strength = CGFloat(strength)
    }
}
