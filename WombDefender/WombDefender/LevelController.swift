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
    
    /////////////////////////////////////////////////////////////////////////////////////
    //
    // Member Variables
    //
    /////////////////////////////////////////////////////////////////////////////////////
    
    fileprivate var _score : Int!
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
    
    fileprivate var _level : Int!
    fileprivate var _probabilityOfMega : Int!
    
    fileprivate var _lengthOfBarrier : Int!
    
    fileprivate var _numberKilledInLevel : Int = 0

    /////////////////////////////////////////////////////////////////////////////////////
    //
    // Initializers
    //
    /////////////////////////////////////////////////////////////////////////////////////
    
    init(delegate: MainGameViewController) {
        _delegate = delegate
        _level = 1
        _score = 25000
        _interval = 500
        _number = Int(floor(2.5*sqrt(Double(_level))))
        _strength = 0.5
        probabilityOfMega = 2*_level
        
        restart()
    }
    
    /////////////////////////////////////////////////////////////////////////////////////
    //
    // Getters/Setters
    //
    /////////////////////////////////////////////////////////////////////////////////////
    
    open var numberOfSperm : Int! {
        get {
            return _number
        }
        set {
            _number = Int(floor(2.5*sqrt(Double(newValue))))
        }
    }
    
    open var numberKilledInLevel : Int {
        get {
            return _numberKilledInLevel
        }
        set {
            _numberKilledInLevel = newValue
        }
    }
    
    open var level : Int! {
        get {
            return _level
        }
        set {
            _level = newValue
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
    
    func restart() {
        _egg = Egg(controller: self)
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
        print("number: \(_number) --- killed: \(_numberKilledInLevel)")
        _score = _score + 1000
        numberKilledInLevel = numberKilledInLevel + 1
        _delegate.removeSwimBehaviorAtIndex(index: index)
        _delegate.removeSpermViewAtIndex(index: index)
        _delegate.reloadView()
        if _number == _numberKilledInLevel && getLives() != 0 {
            print("\(_number) == \(numberKilledInLevel)")
            _numberKilledInLevel = 0
            level = level + 1
            numberOfSperm = level
            _delegate.nextLevel()
        }
    }
    
    func spermIsDemotedAtIndex(index: Int) {
        _score = _score + 50
        _delegate.demoteSpermViewAtIndex(index: index)
    }
    
    func getLives() -> Int {
        return _egg.layers
    }
    
    /** Can alter to increase eggs lives*/
    func setLives(lives : Int) {
        _egg.layers = lives
    }
    
    func getScore() -> Int {
        return _score
    }
    
    func somethingChanged() {
        _delegate.reloadView()
    }
}

/////////////////////////////////////////////////////////////////////////////////////
//
// Constructors
//
/////////////////////////////////////////////////////////////////////////////////////

class EasyLevelController : LevelController {
    override init(delegate: MainGameViewController) {
        super.init(delegate: delegate)
        // Set values specific to easylevelcontroller based on enums in settings.swift
        restart()
    }
    
    override func restart() {
        super.restart()
        _lengthOfBarrier = 10
    }
    
}

class MediumLevelController : LevelController {
    override init(delegate: MainGameViewController) {
        super.init(delegate: delegate)
        // Set values specific to easylevelcontroller based on enums in settings.swift
    }
    
    override func restart() {
        super.restart()
        _lengthOfBarrier = 8
    }
    
}

class HardLevelController : LevelController {
    override init(delegate: MainGameViewController) {
        super.init(delegate: delegate)
        // Set values specific to easylevelcontroller based on enums in settings.swift
    }
    
    override func restart() {
        super.restart()
        _lengthOfBarrier = 5
    }
}
