// File: AudioLocations.swift
// Project: Persona Pop
// Purpose: Enumeration containing audio file names and location in app
// Created by Reese Barnett on 6/6/22.

import Foundation

/// A profile that specifies the source of audio.
enum AudioLocation: String {
    
    /// Background music.
    case background = "space-chillout-14194"
    
    /// UI click sound effect.
    case uiClick = "BubbleUIClick"
    
    /// Keyboard sound effect.
    case keyboard = "na"
    
    /// Level win sound effect.
    case levelWin = "winner"
}
