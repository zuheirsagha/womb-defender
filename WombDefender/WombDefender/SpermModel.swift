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
    case Mega
}

// First red will be darker, second will be lighter, to show less damage
enum SpermSize {
    case Regular
    case Mega
}

enum SpermDamage: Int {
    case Regular = 1
    case Mega = 2
}

protocol SpermDelegate {
    func spermDeadAtIndex(index: Int)
}

class Sperm {
    
    fileprivate var _size: SpermSize!
    fileprivate var _damage: Int!
    fileprivate var _delegate: LevelController!
    fileprivate var _index : Int!

    public class func createNewSperm(type: SpermType, controller: LevelController, index: Int) -> Sperm {
        switch (type) {
            case .Mega:
                return MegaSperm(controller: controller, index: index)
            default:
                return RegularSperm(controller: controller, index: index)
        }
    }
    
    func justHitBarrier() {
        _damage! -= 1;
        if (_damage <= 0) {
            _delegate.spermDeadAtIndex(index: self._index)
        } else {
            _size = SpermSize.Regular
        }
    }
    
    
    func size() -> SpermSize {
        return _size;
    }
}

class RegularSperm : Sperm {
    
    init(controller: LevelController, index: Int) {
        super.init()
        self._index = index
        self._size = SpermSize.Regular
        self._damage = SpermDamage.Regular.rawValue
        self._delegate = controller
    }
}

class MegaSperm : Sperm {
    
    init(controller: LevelController, index: Int) {
        super.init()
        self._index = index
        self._size = SpermSize.Mega
        self._damage = SpermDamage.Mega.rawValue
        self._delegate = controller
    }
}
