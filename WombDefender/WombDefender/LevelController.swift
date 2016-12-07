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
    func nextLevel()
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
    /* strength of the field on this level. There is no Max */
    fileprivate var _strength: Double!
    
    // TODO: Values set based on levels and difficulty (ex. # of sperm, frequency, gravity)
    fileprivate var _scoreIncrementForKillingSperm: Int!
    
    fileprivate var _level = 1
    fileprivate var _probabilityOfMega : Int!
    fileprivate var _aliveSperm = 0
    
    open var level : Int! {
        get {
            return _level
        }
        set {
            _level = newValue
        }
    }
    
    open var aliveSperm : Int! {
        get {
            return _aliveSperm
        }
        set {
            _aliveSperm = newValue
        }
    }
    
    open var probabilityOfMega : Int! {
        get {
            return _probabilityOfMega
        }
        set {
            _probabilityOfMega = newValue
        }
    }

    init(delegate: MainGameViewController) {
        _delegate = delegate
        restart()
    }
    
    func restart() {
        _egg = Egg(controller: self)
    }
    
    func killedSperm() {
        
    }
    
    func numberOfSperm() -> Int {
        return Int(floor(2.5*sqrt(Double(_level))))
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
    
    func allSpermKilled() {
        _delegate.nextLevel()
    }
    
    func spermDeadAtIndex(index: Int) {
        _score += 100
        _aliveSperm -= 1
        _delegate.removeSwimBehaviorAtIndex(index: index)
        _delegate.removeSpermViewAtIndex(index: index)
        if _aliveSperm == 0 {
            _delegate.nextLevel()
        }
    }
    
    func spermIsDemotedAtIndex(index: Int) {
        _score += 50
        _delegate.demoteSpermViewAtIndex(index: index)
    }
    
    func getLives() -> Int {
        return _egg.layers()
    }
    
    /** Can alter to increase eggs lives*/
    func setLives(lives : Int) {
    }
    
    func getScore() -> Int {
        return _score
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
        _interval = 500
        _number = Int(floor(2.5*sqrt(Double(_level))))
        _strength = 0.5
        aliveSperm = _number
        probabilityOfMega = 2*_level
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
