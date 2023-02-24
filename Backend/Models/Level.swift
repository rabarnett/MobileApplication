// File: Level.swift
// Project: Persona Pop
// Purpose: A Level object; used to contain info about a level
// Created by Reese Barnett on 6/5/22.

import Foundation

/// Contains data about a level.
struct Level: Hashable, Codable, Identifiable {
    
    /// Unique number to identify the stage.
    let id: Int
    
    /// Names of the images.
    /// - Important: The images must be predefined in `Assets.xcassets`.
    let imageNames: [String]
    
    /// The answer to be displayed and guessed.
    let answer: String
    
    /// The regular expression used to check the user's input.
    let regex: String
    
    /// Holds whether or not the level is correct.
    private(set) var isCorrect: Bool
    
    /// The index of the current image in ``imageNames``.
    private(set) var currentImageIndex: Int
    
    /// The amount of coins winnable.
    private(set) var winAmount: Int
    
    /// Holds whether or not the level is locked.
    private(set) var isLocked: Bool
    
    /// Holds whether or not a hint was used.
    private(set) var usedHint: Bool
    
    /// The number of images.
    var numberImages: Int {
        imageNames.count
    }

    /// The name of the current image.
    var currentImage: String {
        imageNames[currentImageIndex]
    }
    
    /// Holds whether or not the first image is showing.
    /// Used to reward guessing correct on the first image.
    var isOnFirstImage: Bool {
        currentImageIndex == 0
    }
    
    /// The properly formatted hint.
    var hint: String {
        var hint = ""
        var char = ""

        for i in 0..<answer.count {

            char = String(answer[answer.index(answer.startIndex, offsetBy: i)])
            if char == " " {
                hint += "\n"
            } else if i % 2 == 0{
                hint += (char + " ")
            } else {
                hint += "_ "
            }
        }
        return hint
    }
    
    /// Sets the ``winAmount`` to the specified value.
    /// - Parameter value: the new amount (defaults to 0 if negative).
    mutating func setWinAmount(to value: Int) {
        
        guard value >= 0 else {
            winAmount = 0
            return
        }
        
        winAmount = value
    }
    
    /// Updates the current image to the next image.
    mutating func addCharacter() {
        
        guard currentImageIndex < numberImages - 1 else {return}
        
        currentImageIndex += 1
    }
    
    /// Sets the level to correct and displays all characters.
    mutating func completed() {
        isCorrect = true
        currentImageIndex = numberImages - 1 // Last image in array has all characters
    }
    
    /// Unlocks the level.
    mutating func unlock() {
        isLocked = false
    }
    
    mutating func useHint() {
        usedHint = true
    }
}
