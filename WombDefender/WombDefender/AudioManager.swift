//
//  AudioManager.swift
//  WombDefender
//
//  Created by Zuheir Chikh Al Sagha on 2016-12-10.
//  Copyright © 2016 Zoko. All rights reserved.
//

import Foundation
import AudioToolbox
import AVFoundation

open class AudioManager : NSObject, AVAudioPlayerDelegate {
    
    /////////////////////////////////////////////////////////////////////////////////////
    //
    // Singleton Accessor
    //
    /////////////////////////////////////////////////////////////////////////////////////
    
    open class var sharedInstance : AudioManager {
        struct Static {
            static let instance : AudioManager = AudioManager()
        }
        return Static.instance
    }
    
    /////////////////////////////////////////////////////////////////////////////////////
    //
    // Member Variables
    //
    /////////////////////////////////////////////////////////////////////////////////////
    
    fileprivate var _spermDiedAudioPlayer : AVAudioPlayer?
    
    /////////////////////////////////////////////////////////////////////////////////////
    //
    // Constructors and Initializers
    //
    /////////////////////////////////////////////////////////////////////////////////////
    
    private override init() {
        super.init()
    }
    
    public func initialize() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, with: AVAudioSessionCategoryOptions.duckOthers)
            try AVAudioSession.sharedInstance().setActive(true)
        }
        catch _ {
            // do nothing
        }
        
        loadSounds()
    }
    
    open func loadSounds() {
        _spermDiedAudioPlayer = _loadSound("sperm_died")
    }
    
    
    open func playSound(_ soundType : SoundType) {
        var audioPlayer : AVAudioPlayer?
        
        if soundType == .spermDied {
            audioPlayer = _spermDiedAudioPlayer
        }
        
        _playSound(audioPlayer)
    }
    
    /////////////////////////////////////////////////////////////////////////////////////
    //
    // Private Methods
    //
    /////////////////////////////////////////////////////////////////////////////////////
    
    fileprivate func _loadSound(_ soundName : String) -> AVAudioPlayer? {
        let soundURL = URL(fileURLWithPath: Bundle.main.path(forResource: soundName, ofType: "wav")!)
        
        do {
            let audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer.prepareToPlay()
            audioPlayer.delegate = self
            return audioPlayer
        }
        catch {
            print("Error retrieving audio file")
        }
        
        return nil
    }
    
    fileprivate func _playSound(_ audioPlayer : AVAudioPlayer?) {
        if (audioPlayer?.isPlaying)! {
            audioPlayer?.pause()
            audioPlayer?.currentTime = 0.0
        }
        audioPlayer?.play()
    }
}
