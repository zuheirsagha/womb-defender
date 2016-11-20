//
//  EggModel.swift
//  WombDefender
//
//  Created by Ehimare Okoyomon on 2016-10-04.
//  Copyright © 2016 Zoko. All rights reserved.
//

import Foundation

protocol EggDelegate {
    func eggHasBeenPenetrated()
}

class Egg {
    private var _layers = 3;
    private var _gameover = false;
    private var _delegate: LevelController!
    
    init(controller: LevelController) {
        _delegate = controller
    }
    
    func justGotHitBySperm() {
        _layers -= 1;
        if (_layers < 1) {
            _gameover = true
            _delegate.eggHasBeenPenetrated()
        } else {
            _delegate.somethingChanged()
        }
    }
    
    func keepPlaying() -> Bool {
        return !_gameover
    }
    
    func layers() -> Int {
        return _layers
    }
}
