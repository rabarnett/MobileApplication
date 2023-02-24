// File: GameError.swift
// Project: Persona Pop
// Purpose: A profile that specifies various game errors
// Created by Reese Barnett on 1/3/23.


import Foundation

/// A profile that specifies various game errors.
enum GameError: Error {
    
    /// Attempting to access/modify a locked stage.
    case lockedStage
    
    /// Attempting to access/modify a locked level.
    case lockedLevel
    
    /// Attempting to access a level that does not exist.
    case invalidLevel
    
    /// Attempting to buy a stage or level without enough ``CoinModel/totalCoins`` or ``CoinModel/totalGems``.
    case insufficientFunds
    
    /// Attempting to use a hint without enough ``CoinModel/totalHints``
    case insufficientHints
}
