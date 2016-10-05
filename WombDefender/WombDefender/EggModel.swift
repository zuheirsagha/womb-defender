//
//  EggModel.swift
//  WombDefender
//
//  Created by Ehimare Okoyomon on 2016-10-04.
//  Copyright © 2016 Zoko. All rights reserved.
//

import Foundation

class Egg {
    private var _layers = 3;
    private var _gameover = false;
    
    func justGotHitBySperm() {
        _layers -= 1;
        
    }
    
    func keepPlaying() -> Bool {
        return !_gameover;
    }
    
    func layers() -> Int {
        return _layers
    }
}
