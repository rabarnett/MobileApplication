// File: SoundEnabler.swift
// Project: Persona Pop
// Purpose: An object that contains data about what sounds can play
// Created by Reese Barnett on 6/6/22.

import Foundation

/// Contains data about what sounds are enabled.
struct SoundEnabler: Codable {
    
    /// Holds whether or not the background music is on.
    private(set) var musicOn = true
    
    /// Holds whether or not the UI sound effects  are on.
    private(set) var effectsOn = true
    
    /// Holds whether or not the UI haptics are on.
    private(set) var hapticsOn = true
    
    /// Toggles ``musicOn``.
    mutating func toggleMusic() {
        musicOn.toggle()
    }
    
    /// Toggles ``effectsOn``.
    mutating func toggleEffects() {
        effectsOn.toggle()
    }
    
    /// Toggles ``hapticsOn``.
    mutating func toggleHaptics() {
        hapticsOn.toggle()
    }
}
