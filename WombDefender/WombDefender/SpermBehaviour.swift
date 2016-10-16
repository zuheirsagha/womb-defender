//
//  SpermBehaviour.swift
//  WombDefender
//
//  Created by Zuheir Chikh Al Sagha on 2016-10-06.
//  Copyright © 2016 Zoko. All rights reserved.
//

import UIKit

class SpermBehaviour: UIDynamicBehavior {
    
    // TODO: figure out how to make gravity center of screen (may need to use SpriteKit)
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
        dib.elasticity = 0.5
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
        //Y is opposite because 0 at top in ios.
        gravity.angle = atan((y-centreY)/(x-centreX))
        print("GRAVITY ANGLE : \(gravity.angle)")
    }
}
