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
    
    /////////////////////////////////////////////////////////////////////////////////////
    //
    // Singleton Accessor
    //
    /////////////////////////////////////////////////////////////////////////////////////
    
    open class var sharedInstance : SettingsManager {
        struct Static {
            static let instance : SettingsManager = SettingsManager()
        }
        return Static.instance
    }
    
    /////////////////////////////////////////////////////////////////////////////////////
    //
    // Member Variables
    //
    /////////////////////////////////////////////////////////////////////////////////////
    
    fileprivate var _delegate : SettingsManagerDelegate?
    fileprivate var _appIsMute : Bool = false
    fileprivate var _appFXIsMute : Bool = false
    fileprivate var _highestScore : Int = 0
    fileprivate var _difficulty : Difficulty = .Easy
    
    fileprivate var _numberOfFirstPowerUps : Int = 0
    fileprivate var _numberOfSecondPowerUps : Int = 0
    fileprivate var _numberOfThirdPowerUps : Int = 0
    
    fileprivate var _firstTimeOrTutorialPlayed : Bool = false
    
    fileprivate var _country : String = "Zoko"
    
    fileprivate var _coins : Int = 0
    
    /////////////////////////////////////////////////////////////////////////////////////
    //
    // Constructor and Initializer
    //
    /////////////////////////////////////////////////////////////////////////////////////
    
    public init() {
    }
    
    open func initialize() {
        _loadSettings()
    }
    
    /////////////////////////////////////////////////////////////////////////////////////
    //
    // Delegate
    //
    /////////////////////////////////////////////////////////////////////////////////////

    open var delegate : SettingsManagerDelegate? {
        get {
            return _delegate
        }
        set {
            _delegate = newValue
        }
    }
    
    /////////////////////////////////////////////////////////////////////////////////////
    //
    // Getters/Setters
    //
    /////////////////////////////////////////////////////////////////////////////////////
    
    open var firstTimeOrTutorialPlayed : Bool {
        get {
            return _firstTimeOrTutorialPlayed
        }
        set {
            _firstTimeOrTutorialPlayed = newValue
            _saveSettings()
        }
    }
    
    open var difficulty : Difficulty {
        get {
            return _difficulty
        }
        set {
            _difficulty = newValue
            _saveSettings()
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
    
    open var appFXIsMute : Bool {
        get {
            return _appFXIsMute
        }
        set {
            _appFXIsMute = newValue
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
    
    open var coins : Int {
        get {
            return _coins
        }
        set {
            _coins = newValue
            _saveSettings()
        }
    }
    
    open var numberOfFirstPowerUps : Int {
        get {
            return _numberOfFirstPowerUps
        }
        set {
            _numberOfFirstPowerUps = newValue
            _saveSettings()
        }
    }
    
    open var numberOfSecondPowerUps : Int {
        get {
            return _numberOfSecondPowerUps
        }
        set {
            _numberOfSecondPowerUps = newValue
            _saveSettings()
        }
    }
    
    open var country : String {
        get {
            return _country
        }
        set {
            _country = newValue
            _saveSettings()
        }
    }
    
    open var numberOfThirdPowerUps : Int {
        get {
            return _numberOfThirdPowerUps
        }
        set {
            _numberOfThirdPowerUps = newValue
            _saveSettings()
        }
    }
    
    /////////////////////////////////////////////////////////////////////////////////////
    //
    // Private Methods
    //
    /////////////////////////////////////////////////////////////////////////////////////
    
    fileprivate func _loadSettings() {
        
        let defaults = UserDefaults.standard
        
        _appIsMute = defaults.bool(forKey: "appIsMute")
        _appFXIsMute = defaults.bool(forKey: "appFXIsMute")
        _highestScore = defaults.integer(forKey: "highestScore")
        
        let difficulty = defaults.integer(forKey: "difficulty")
        _difficulty = Difficulty(rawValue: difficulty)!
        
        if defaults.string(forKey: "country") != nil {
            _country = defaults.string(forKey: "country")!
        }
        
        _firstTimeOrTutorialPlayed = defaults.bool(forKey: "firstTimeOrTutorialPlayed")
        
        _numberOfFirstPowerUps = defaults.integer(forKey: "numberOfFirstPowerUps")
        _numberOfSecondPowerUps = defaults.integer(forKey: "numberOfSecondPowerUps")
        _numberOfThirdPowerUps = defaults.integer(forKey: "numberOfThirdPowerUps")
        
        _coins = defaults.integer(forKey: "coins")
    }
    
    fileprivate func _saveSettings() {
        
        let defaults = UserDefaults.standard
        
        defaults.set(_appIsMute, forKey: "appIsMute")
        defaults.set(_appFXIsMute, forKey: "appFXIsMute")
        defaults.set(_highestScore, forKey: "highestScore")
        
        let difficulty = _difficulty.rawValue
        defaults.set(difficulty, forKey: "difficulty")
        
        defaults.set(_country, forKey: "country")
        
        defaults.set(_firstTimeOrTutorialPlayed, forKey: "firstTimeOrTutorialPlayed")
        
        defaults.set(_numberOfFirstPowerUps, forKey: "numberOfFirstPowerUps")
        defaults.set(_numberOfSecondPowerUps, forKey: "numberOfSecondPowerUps")
        defaults.set(_numberOfThirdPowerUps, forKey: "numberOfThirdPowerUps")
        
        defaults.set(_coins, forKey: "coins")
        
        _delegate?.onSettingsDidChange()
        
    }
    
    
}
    
