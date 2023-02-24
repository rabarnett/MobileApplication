// File: Stage.swift
// Project: Persona Pop
// Purpose: A Stage object; used to contain info about a stage
// Created by Reese Barnett on 6/5/22.

import Foundation

/// Contains data about a stage.
struct Stage: Hashable, Codable, Identifiable {
    
    /// Unique number to identify the stage
    /// - Important: The id has to be the index of the stage in the `stages` array.
    let id: Int
    
    /// The display name of the stage.
    let name: String
    
    /// The color of the associated icons.
    /// - Important: The color must be already defined in `Assets.xcassets`.
    let color: String
    
    /// The levels in the stage.
    var levels: [Level]
    
    /// Holds whether or not the stage is locked.
    private(set) var isLocked: Bool
    
    /// The number of levels in the stage.
    var levelCount: Int {levels.count}
    
    /// The number of completed levels in the stage.
    var numLevelsComplete: Int {
        levels.filter{$0.isCorrect}.count
    }
    
    /// The percentage of the levels completed in the stage.
    var percentComplete: Int {
        Int((Float(numLevelsComplete) / Float(levelCount)) * 100)
    }
    
    /// Unlocks the stage.
    mutating func unlock() {
        isLocked = false
    }
    
    /// Gets the index of the next level that is unanswerd.
    /// - Parameter index: the index of the current level
    /// - Returns: the index of the level.
    func nextLevel(from index: Int) -> Int? {
        
        // Checks from current to end of stage
        for i in (index+1)..<levels.count {
            if !levels[i].isCorrect {
                return i
            }
        }
        
        // Checks from start to current
        for i in 0..<index {
            if !levels[i].isCorrect {
                return i
            }
        }
        
        return nil
    }
}
