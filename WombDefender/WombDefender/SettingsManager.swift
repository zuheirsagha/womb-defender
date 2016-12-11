//
//  SettingsManager.swift
//  WombDefender
//
//  Created by Zuheir Chikh Al Sagha on 2016-12-10.
//  Copyright © 2016 Zoko. All rights reserved.
//

import Foundation

public protocol SettingsManagerDelegate : NSObjectProtocol {
    func onSettingsDidChange()
}

open class SettingsManager {
    
    open class var sharedInstance : SettingsManager {
        struct Static {
            static let instance : SettingsManager = SettingsManager()
        }
        return Static.instance
    }
    
    fileprivate var _delegate : SettingsManagerDelegate?
    fileprivate var _appIsMute : Bool = false
    fileprivate var _highestScore : Int = 0
    fileprivate var _difficulty : Difficulty = .Easy
    
    public init() {
    }
    
    open func initialize() {
        _loadSettings()
    }
    
    open var difficulty : Difficulty {
        get {
            return _difficulty
        }
        set {
            _difficulty = newValue
        }
    }
    
    open var delegate : SettingsManagerDelegate? {
        get {
            return _delegate
        }
        set {
            _delegate = newValue
        }
    }
    
    open var appIsMute : Bool {
        get {
            return _appIsMute
        }
        set {
            _appIsMute = newValue
            _saveSettings()
        }
    }
    
    open var highestScore : Int {
        get {
            return _highestScore
        }
        set {
            _highestScore = newValue
            _saveSettings()
        }
    }
    
    fileprivate func _loadSettings() {
        
        let defaults = UserDefaults.standard
        
        _appIsMute = defaults.bool(forKey: "appIsMute")
        _highestScore = defaults.integer(forKey: "highestScore")
        let difficulty = defaults.integer(forKey: "difficulty")
        _difficulty = Difficulty(rawValue: difficulty)!
        
    }
    
    fileprivate func _saveSettings() {
        
        let defaults = UserDefaults.standard
        
        defaults.set(_appIsMute, forKey: "appIsMute")
        defaults.set(_highestScore, forKey: "highestScore")
        let difficulty = _difficulty.rawValue
        defaults.set(difficulty, forKey: "difficulty")
        
        _delegate?.onSettingsDidChange()
    }
    
    
}
