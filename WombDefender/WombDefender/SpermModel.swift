//
//  SpermModel.swift
//  WombDefender
//
//  Created by Ehimare Okoyomon on 2016-10-04.
//  Copyright © 2016 Zoko. All rights reserved.
//

import Foundation

enum SpermType {
    case Regular
    case Extra
}

// First red will be darker, second will be lighter, to show less damage
enum SpermSize {
    case Regular
    case Mega
}

enum SpermDamage: Int {
    case Regular = 1
    case Extra = 2
}

class Sperm {
    
    private var _size: SpermSize
    private var _damage: Int
    private var _isDead: Bool
    
    init(type: SpermType) {
        switch (type) {
            case .Extra:
                _size = SpermSize.Mega
                _damage = SpermDamage.Extra.rawValue
            default:
                _size = SpermSize.Regular
                _damage = SpermDamage.Regular.rawValue
        }
        _isDead = false
    }
    
    func justHitBarrier() {
        _damage -= 1;
        if (_damage <= 0) {
            _isDead = true
        } else {
            _size = SpermSize.Regular
        }
    }
    
    func isDead() -> Bool {
        return _isDead
    }
    
    func size() -> SpermSize {
        return _size;
    }
    
}
