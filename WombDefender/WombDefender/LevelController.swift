//
//  LevelController.swift
//  WombDefender
//
//  Created by Ehimare Okoyomon on 2016-10-05.
//  Copyright © 2016 Zoko. All rights reserved.
//

import Foundation

protocol LevelControllerDelegate {
    func gameIsOver()
    func removeSpermViewAtIndex(index: Int)
}

class LevelController : SpermDelegate, EggDelegate {
    fileprivate var _score = 0
    fileprivate var _delegate : MainGameViewController!
    fileprivate var _egg : Egg!
    /* time interval between when sperm is released (in milliseconds) */
    fileprivate var _interval: Int!
    /* number of sperm to be released in this level. */
    fileprivate var _number: Int!
    /* strength of the field on this level. Max is 1.0 */
    fileprivate var _strength: Double!
    
    // TODO: Values set based on levels and difficulty (ex. # of sperm, frequency, gravity)
    fileprivate var _scoreIncrementForKillingSperm: Int!
    
    init(delegate: MainGameViewController) {
        _delegate = delegate
        restart()
    }
    
    func nextLevel() {
        
    }
    
    func restart() {
        _egg = Egg(controller: self)
    }
    
    func killedSperm() {
        
    }
    
    func numberOfSperm() -> Int {
        return _number
    }
    
    func interval() -> Int {
        return _interval
    }
    
    func fieldStrength() -> Double {
        return _strength
    }
    
    func spermHitEgg() {
        _egg.justGotHitBySperm()
    }
    
    func eggHasBeenPenetrated() {
        _delegate.gameIsOver()
    }
    
    func spermDeadAtIndex(index: Int) {
        _delegate.removeSpermViewAtIndex(index: index)
    }
    
    func spermIsDemotedAtIndex(index: Int) {
        // add method to decrease mega sperm to regular in main.
    }
    
    func getLives() -> Int {
        return _egg.layers()
    }
    
    /** Can alter to increase eggs lives*/
    func setLives(lives : Int) {
    }
    
    func somethingChanged() {
        _delegate.reloadView()
    }
    
}

class EasyLevelController : LevelController {
    override init(delegate: MainGameViewController) {
        super.init(delegate: delegate)
        // Set values specific to easylevelcontroller based on enums in settings.swift
        restart()
    }
    
    override func restart() {
        super.restart()
        _interval = 1500
        _number = 3
        _strength = 0.3
    }
    
}

class MediumLevelController : LevelController {
    override init(delegate: MainGameViewController) {
        super.init(delegate: delegate)
        // Set values specific to easylevelcontroller based on enums in settings.swift
    }
    
}

class HardLevelController : LevelController {
    override init(delegate: MainGameViewController) {
        super.init(delegate: delegate)
        // Set values specific to easylevelcontroller based on enums in settings.swift
    }
    
}
