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
enum SpermColor {
    case WHITE
    case RED1
    case RED2
}

enum SpermDamage: Int {
    case Regular = 1
    case Extra = 2
}

class Sperm {
    
    private var _color: SpermColor
    private var _damage: Int
    private var _isDead: Bool
    
    init(type: SpermType) {
        switch (type) {
            case .Extra:
                _color = SpermColor.RED1
                _damage = SpermDamage.Extra.rawValue
            default:
                _color = SpermColor.WHITE
                _damage = SpermDamage.Regular.rawValue
        }
        _isDead = false
    }
    
    func justHitBarrier() {
        _damage -= 1;
        if (_damage <= 0) {
            _isDead = true
        } else {
            _color = SpermColor.RED2
        }
    }
    
    func isDead() -> Bool {
        return _isDead
    }
    
    func color() -> SpermColor {
        return _color;
    }
    
}
