// File: CoinModel.swift
// Project: Persona Pop
// Purpose: An object that contains data about the apps coin system
// Created by Reese Barnett on 6/6/22.

import Foundation

/// Contains data for app coin system.
struct CoinModel: Codable {
    
    /// The cost of a stage.
    let stageValue: Value
    
    /// The cost of a level (gems).
    let levelValue: Value
    
    /// The most coins winnable on a level.
    let maxWinAmount: Int
    
    /// The total amount of coins the user has.
    private(set) var totalCoins: Int
    
    /// The total aount of gems the user has.
    private(set) var totalGems: Int
    
    /// The total amont of hints the user has.
    private(set) var totalHints: Int
    
    /// The least amount of coins winnable on a level.
    private let minWinAmount: Int
    
    /// Sets default values.
    init() {
        stageValue = Value(coins: 1000, gems: 10)
        levelValue = Value(coins: 100, gems: 3)
        maxWinAmount = 200
        minWinAmount = 112
        totalCoins = 0
        totalGems = 10
        totalHints = 4
    }
    
    /// The most coins that can be lost on a level.
    var maxCoinsLose: Int {
        maxWinAmount - minWinAmount
    }
    
    /**
     Increases the specified currency by the specified amount.
     - Parameters:
        - amount: The amount to increase by.
        - currency: The currency that should increase.
     - Note: `amount` has to be greater than 0.
    */
    mutating func add(_ amount: Int, to currency: Currency) {
        
        guard amount > 0 else {return}
        
        switch currency {
        case .coins:
            totalCoins += amount
        case .gems:
            totalGems += amount
        }
    }
    
    /**
     Purchases a stage or level with the specified currency.
     - Parameters:
        - item: The item being bought
        - currency: The currency being used to buy the item.
     - Throws: ``GameError/insufficientFunds``.
    */
    mutating func buy(_ item: Item, _ currency: Currency) throws {
        
        let cost: Int
        let usersAmount: Int // The amount of coins or gems the user has.
        
        switch item {
            
        case .stage:
            switch currency {
            case .coins:
                cost = stageValue.coins
                usersAmount = totalCoins
            case .gems:
                cost = stageValue.gems
                usersAmount = totalGems
            }
            
        case .level:
            switch currency {
            case .coins:
                cost = levelValue.coins
                usersAmount = totalCoins
            case .gems:
                cost = levelValue.gems
                usersAmount = totalGems
            }
        }
        
        guard usersAmount >= cost else {
            throw GameError.insufficientFunds
        }
        
        if currency == .coins {
            totalCoins -= cost
        } else {
            totalGems -= cost
        }
    }
    
    /// Removes one hint from the users total.
    /// - Throws: ``GameError/insufficientHints``.
    mutating func removeHint() throws {
        guard totalHints > 0 else {
            throw GameError.insufficientHints
        }
        totalHints -= 1
    }
        
    /// A profile that specifies items that can be purchased with coins.
    enum Item: String {
        
        /// A stage can be purchased.
        case stage = "Stage"
        
        /// A level can be purchased.
        case level = "Level"
    }
    
    /// A profile that specifies in game currencies that can be used.
    enum Currency {
        
        /// In game coin currency.
        case coins
        
        /// In game gems currency.
        case gems
    }
    
    /// Contains the in game value in coins and in gems.
    struct Value: Codable {
        
        /// The value in coins.
        let coins: Int
        
        /// The value in gems.
        let gems: Int
    }
}
