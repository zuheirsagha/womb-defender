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
    fileprivate var _livesLeft: Int!
    fileprivate var _delegate : MainGameViewController!
    fileprivate var _egg : Egg!
    
    // TODO: Values set based on levels and difficulty (ex. # of sperm, frequency, gravity)
    fileprivate var sperms = [Sperm]()
    fileprivate var _scoreIncrementForKillingSperm: Int!
    
    
    
    init(delegate: MainGameViewController) {
        _delegate = delegate
        _egg = Egg(controller: self)
    }
    
    func nextLevel() {
        
    }
    
    func restart() {
        
    }
    
    func killedSperm() {
        
    }
    
    func spermHitEgg() {
        _egg.justGotHitBySperm()
    }
    
    func eggHasBeenPenetrated() {
        _delegate.gameIsOver()
    }
    
    func spermDeadAtIndex(index: Int) {
        sperms.remove(at: index)
        _delegate.removeSpermViewAtIndex(index: index)
    }
    
    func getLives() -> Int {
        return _livesLeft
    }
    
    func setLives(lives : Int) {
        _livesLeft = lives
    }
    
}

class EasyLevelController : LevelController {
    override init(delegate: MainGameViewController) {
        super.init(delegate: delegate)
        // Set values specific to easylevelcontroller based on enums in settings.swift
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
