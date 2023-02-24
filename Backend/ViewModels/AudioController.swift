// File: AudioController.swift
// Project: Persona Pop
// Purpose: Plays, stops, and controls audio/haptics
// Created by Reese Barnett on 5/8/22.

import Foundation
import AVFAudio
import UIKit

/// Manages audio and haptics.
final class AudioController: ObservableObject {
    
    /// Data relevant to sound/haptic settings
    @Published private(set) var sound: SoundEnabler
    
    /// Plays background music.
    private var musicPlayer: AVAudioPlayer?
    
    /// Plays UI sound effects.
    private var effectPlayer: AVAudioPlayer?
    
    /// Background music local url
    private let backgroundURL: URL! = Bundle.main.url(forResource: AudioLocation.background.rawValue, withExtension: "mp3")
    
    /// UI click sound local url
    private let clickURL: URL! = Bundle.main.url(forResource: AudioLocation.uiClick.rawValue, withExtension: "mp3")
    
    /// Win sound local url
    private let winURL: URL! = Bundle.main.url(forResource: AudioLocation.levelWin.rawValue, withExtension: "wav")
    
    /// Retrieves saved data if there is any, else intializes with default values.
    init() {
        
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            // Allows other app to play music while in game
            try audioSession.setCategory(.ambient)
        } catch{}
        
        guard let data = UserDefaults.standard.data(forKey: "SoundEnabler") else {
            sound = SoundEnabler()
            return
        }
        
        guard let decoded = try? JSONDecoder().decode(SoundEnabler.self, from: data) else {
            sound = SoundEnabler()
            return
        }
        
        sound = decoded
    }
    
    /// Saves the current state of ``SoundEnabler`` to `UserDefaults`.
    private func save() {
        
        guard let encoded = try? JSONEncoder().encode(sound) else {return}
        
        UserDefaults.standard.set(encoded, forKey: "SoundEnabler")
    }
            
    /// Plays the specified sound.
    /// - Parameter source: Where the sound is coming from in the app.
    func play(sound source: AudioLocation) {
        
        do {
            switch source {
                
            case .background:
                guard sound.musicOn else {return}
                try musicPlayer = AVAudioPlayer(contentsOf: backgroundURL)
                musicPlayer?.numberOfLoops = -1
                musicPlayer?.play()
                
            case .uiClick:
                guard sound.effectsOn else {return}
                try effectPlayer = AVAudioPlayer(contentsOf: clickURL)
                effectPlayer?.play()
                
            case .levelWin:
                guard sound.effectsOn else {return}
                try effectPlayer = AVAudioPlayer(contentsOf: winURL)
                effectPlayer?.play()
                
                guard sound.hapticsOn else {return}
                UINotificationFeedbackGenerator().notificationOccurred(.success)
                
            case .keyboard:
                guard sound.effectsOn else {return}
                //TODO: Add keyboard sound
            }
        } catch {
            print("ERROR: Audio player could not identify the local file")
        }
    }
    
    /// Toggles background music on/off.
    func toggleMusic() {
    
        // Value must be copied b/c it has to be
        // toggled before stoping or playing music
        let prev = sound.musicOn
        
        sound.toggleMusic()
        
        prev ? musicPlayer?.stop() : play(sound: .background)

        save()
    }
    
    /// Toggles UI click sound effect on/off.
    func toggleEffects() {
        sound.toggleEffects()
        save()
    }
    
    /// Toggles haptic engine on/off.
    func toggleHaptics() {
        sound.toggleHaptics()
        save()
    }
}
