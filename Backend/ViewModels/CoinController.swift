// File: CoinController.swift
// Project: Persona Pop
// Purpose: Stores and modifies the amount of coins the user has
// Created by Reese Barnett on 2/6/22.

import Foundation

/// Manages the coin system.
final class CoinController: ObservableObject {
    
    /// All the data relevant to the in game currency.
    @Published private var coinModel: CoinModel
    
    /// The key used to store `coinModel` in `UserDefaults`.
    private let coinKey = "CoinModel"
    
    /// Retrieves saved data if there is any, else intializes with default values.
    init() {
        
        guard let data = UserDefaults.standard.data(forKey: coinKey) else {
            coinModel = CoinModel()
            return
        }
        
        guard let decoded = try? JSONDecoder().decode(CoinModel.self, from: data) else {
            coinModel = CoinModel()
            return
        }
        
        coinModel = decoded
    }
    
    /// Saves the current state of ``CoinModel`` to `UserDefaults`.
    private func save() {
        
        guard let encoded = try? JSONEncoder().encode(coinModel) else {return}
        
        UserDefaults.standard.set(encoded, forKey: coinKey)
    }
    
    /// The coin cost of a stage.
    var stageValue: CoinModel.Value {
        coinModel.stageValue
    }
    
    /// The coin cost of a stage.
    var levelValue: CoinModel.Value {
        coinModel.levelValue
    }
    
    /// The amount of coins the user has.
    var coins: Int {
        coinModel.totalCoins
    }
    
    /// The amount of gems the user has.
    var gems: Int {
        coinModel.totalGems
    }
    
    /// The amount of hints the user has.
    var hints: Int {
        coinModel.totalHints
    }
    
    /**
     Buys the specified item and removes necessary coins/gems.
     - Parameters:
        - item: The item that is being bought.
        - index: The index of the `stage` or `level`.
        - currency: The currency being used to buy the item.
        - gameModel: Needed to in order to unlock bought item.
     - Throws: ``GameError/insufficientFunds``.
     - Note: A level's `id` is NOT equal to its index in `levels`.
     - Note: A stage's `id` IS equal to its index in `stages`.
    */
    func buy(_ item: CoinModel.Item, atIndex index: Int, with currency: CoinModel.Currency, gameModel: GameController) throws {
        try coinModel.buy(item, currency)
        
        switch item {
        case .stage:
            gameModel.unlockStage(atIndex: index)
        case .level:
            gameModel.unlockLevel(atIndex: index)
        }
        save()
    }
    
    /**
     Adds specified amount of coins to the user's total coins.
     - Parameter amount: The amount of coins to add (must be greater than 0 to take affect).
     */
    func coinsWon(_ amount: Int) {
        
        coinModel.add(amount, to: .coins)
        
        // Earn gem if user wins while on first image
        if amount == coinModel.maxWinAmount {
            coinModel.add(1, to: .gems)
        }
        
        save()
    }
    
    /// Updates the amount of coins that can be won on the current level.
    /// - Parameter gameModel: Updates the win amount for the current level.
    func updateWinAmount(_ gameModel: GameController) {
        
        // Minus 1 because the first image is already displayed
        let imageValue = Float(coinModel.maxCoinsLose) / (Float(gameModel.level.numberImages) - 1)
        let amount = Int(Float(coinModel.maxWinAmount) - (imageValue * Float(gameModel.level.currentImageIndex)))
        
        gameModel.setLevelWinAmount(to: amount)
    }
    
    /// Removes one hint from the users total.
    /// - Throws: ``GameError/insufficientHints``.
    func removeHint(_ gameModel: GameController) throws {
        
        guard !gameModel.level.usedHint else {return}
        try coinModel.removeHint()
        gameModel.useHint()
        save()
    }
}
