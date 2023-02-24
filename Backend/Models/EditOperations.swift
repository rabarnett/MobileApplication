// File: EditOperations.swift
// Project: Persona Pop
// Purpose: An enumeration describing ways to edit user input
// Created by Reese Barnett on 6/6/22.

import Foundation

/// A profile that specifies operations on user input.
enum EditOperation {
    
    /// Adding a letter.
    case addLetter
    
    /// Adding a space.
    case space
    
    /// Deleting the last letter or space.
    case delete
}
