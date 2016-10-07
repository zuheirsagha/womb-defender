//
//  SpermView.swift
//  WombDefender
//
//  Created by Zuheir Chikh Al Sagha on 2016-10-06.
//  Copyright © 2016 Zoko. All rights reserved.
//

import UIKit

class SpermView : UIView {
    
    private lazy var animator : UIDynamicAnimator = UIDynamicAnimator(referenceView: self)
    private let swimBehaviour = SpermBehaviour()
    
    var animating : Bool = false {
        didSet {
            if animating {
                animator.addBehavior(swimBehaviour)
            } else {
                animator.removeBehavior(swimBehaviour)
            }
        }
    }
    
    func addSperm() {
        
    }
    
}
