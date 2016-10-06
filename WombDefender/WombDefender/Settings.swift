//
//  Settings.swift
//  WombDefender
//
//  Created by Ehimare Okoyomon on 2016-10-05.
//  Copyright © 2016 Zoko. All rights reserved.
//

import Foundation

// Difficulty level
enum Difficulty {
    case Easy
    case Medium
    case Hard
}

// Int corresponds to length of barrier based on difficulty level. Not accurate, just arbitrary values.
enum Length : Int {
    case Easy = 20
    case Medium = 15
    case Hard = 10
}

// Int corresponds to the Rough
enum Frequency : Int {
    case LVL1 = 1
}


// TODO: Likelyhood of getting a MegaSperm - might have a different structure for levels?
enum MegaProbability : Int{
    case LVL1
    case LVL2
}

// TODO: How fast the sperm will fall - implement some scale
enum Gravity : Int {
    case Slowest
}

// TODO: How many will pass to beat a level - implement some scale
// NOTE FROM ZUHEIR: Amount should be based on score, i.e. reached 100pts -> go to level 2, 200pts -> level 3 -> etc...
//                      outlined functionality in spec doc
enum Amount : Int {
    case Smallest
}

class Settings {
    static let common = Settings()
    static var currentDifficulty: Difficulty = Difficulty.Easy
    
    func getDifficulty() -> Difficulty {
        return Settings.currentDifficulty
    }
    
    class func getNewLevelControllerWithCurrentDifficulty(gameController: MainGameViewController) -> LevelController {
        switch (currentDifficulty) {
            case .Easy:
                return EasyLevelController(delegate: gameController)
            case .Medium:
                return MediumLevelController(delegate: gameController)
            case .Hard:
                return HardLevelController(delegate: gameController)
        }
    }
}
