// File: GameController.swift
// Project: Persona Pop
// Purpose: Contains, modifies, and saves stage and level data
// Created by Reese Barnett on 2/5/22.

import Foundation

/// Manages stage and level data.
final class GameController: ObservableObject {
    
    /// All the stages and their respective levels.
    @Published private var stages: [Stage]
    
    /// The user's input.
    @Published private var userInput = ""
    
    /// The index of the current stage.
    /// - Note: The value persist even if the stage is not opened.
    @Published private var currentStage = 0
    
    /// The index of the current stage.
    /// - Note: The value persist even if the level is not opened.
    @Published private var currentLevel = 0
    
    /// The number of times the user gets a level correct without adding a character.
    @Published private(set) var singleImageCorrect = 0
    
    /// The key used to store `stages` in `UserDefaults`.
    private let stageKey = "Stages"
    
    /// Retrieves saved data if there is any, else intializes with default values.
    init() {
        
        let stageJSON = "StageData.json"
        singleImageCorrect = UserDefaults.standard.integer(forKey: "singleImageCorrect")
        
        guard let data = UserDefaults.standard.data(forKey: stageKey) else {
            stages = load(stageJSON)
            return
        }
        
        guard let decoded = try? JSONDecoder().decode([Stage].self, from: data) else {
            stages = load(stageJSON)
            return
        }
        
        stages = decoded
    }
    
    /// Saves the current state of ``Stage`` array  to `UserDefaults`.
    private func save() {
        
        guard let encoded = try? JSONEncoder().encode(stages) else {return}
        
        UserDefaults.standard.set(encoded, forKey: stageKey)
    }
    
    /// A `Bool` representing if the tutorial should be shown on the current level.
    var showTutorial: Bool {
        let hasClicked = level.currentImageIndex > 0
        let levelCorrect = level.isCorrect
        let isStageOne = stage.id == 0
        let isLevelOne = level.id == 101
        
        return isStageOne && isLevelOne && !levelCorrect && !hasClicked
    }
    
    //-------------------STAGE-----------------//
    // MARK: STAGE
    
    /// The current stage.
    /// - Attention: This is a copy not a refrence.
    var stage: Stage {
        stages[currentStage]
    }
    
    /// The total number of stages in the app.
    var numStages: Int {
        stages.count
    }
    
    /**
     Gets a copy of the specified stage.
     - Parameter index: The index of the stage in the `stages` array.
     - Note: A stage's `id` is equal to its index in `stages`.
     - Returns: A ``Stage``,  if one exist at the specified index, else `nil`.
    */
    func getStage(atIndex index: Int) -> Stage? {
        
        guard index > -1 else {return nil}
        guard index < numStages else {return nil}
        
        return stages[index]
    }
    
    /**
     Sets the current stage to the specified stage.
     - Parameter index: The index of the stage in the `stages` array.
     - Note: A stage's `id` is equal to its index in `stages`.
     - Throws: ``GameError/lockedStage``.
    */
    func setStage(to index: Int) throws {
        
        guard let stage = getStage(atIndex: index) else {
            print("Error: Cannot get stage at index \(index)")
            return
        }
        guard !stage.isLocked else {
            throw GameError.lockedStage
        }
        
        currentStage = index
    }
    
    /**
     Unlocks the specified stage.
     - Parameter index: The index of the stage in the `stages` array.
     - Note: A stage's `id` is equal to its index in `stages`.
    */
    func unlockStage(atIndex index: Int) {
        
        guard getStage(atIndex: index) != nil else {return}
        
        stages[index].unlock()
        save()
    }
    
    /**
     Changes the current level to the next level, else changes view to ``StageView``.
     This is used to allow for easy navigation after completing a level.
     - Parameter viewRouter: Changes the view.
     */
    func moveOn(_ viewRouter: ViewRouter) {
        
        do {
            
            guard let nextLevel = stage.nextLevel(from: currentLevel) else {
                throw GameError.invalidLevel
            }
            
            try setLevel(to: nextLevel)
            
        } catch GameError.invalidLevel {
            viewRouter.toStagesView()
            
        } catch {}
    }
    
    //-------------------LEVEL-----------------//
    // MARK: LEVEL
    
    /// The current level.
    /// - Attention: This is a copy not a refrence.
    var level: Level {
        stages[currentStage].levels[currentLevel]
    }
    
    /**
     Gets a copy of the specified level from the current stage.
     - Parameter index: The index of the level in the ``Stage/levels`` array.
     - Returns: ``Level`` if one exist at the specified index, else `nil`.
     - Note: This only returns a level in the current stage. Use ``GameController/setStage(to:)`` to change the current stage.
     - Attention: A level's `id`  is NOT equal to its index in the ``Stage/levels`` array.
     */
    func getLevel(atIndex index: Int) -> Level? {
        
        guard index > -1 else {return nil}
        guard index < stage.levelCount else {return nil}
        
        return stage.levels[index]
    }
    
    /**
     Sets the current level to the specified level.
     - Parameter index: The index of the level in the ``Stage/levels`` array.
     - Attention: A level's `id` is NOT equal to its index in `stage.levels`.
     - Throws: ``GameError/invalidLevel`` or ``GameError/lockedLevel``.
    */
    func setLevel(to index: Int) throws {

        guard let level = getLevel(atIndex: index) else {
            throw GameError.invalidLevel
        }
        guard !level.isLocked else {
            throw GameError.lockedLevel
        }
        
        currentLevel = index
        userInput = ""
    }
    
    
    /**
     Sets the amount of coins the user can win on the current level.
     - Parameter value: The amount of coins winnable.
     - Note: Negative values defalut to 0.
    */
    func setLevelWinAmount(to value: Int) {
        stages[currentStage].levels[currentLevel].setWinAmount(to: value)
        save()
    }
    
    /// Unlocks the specified level.
    /// - Parameter index: The index of the level in the ``Stage/levels`` array.
    func unlockLevel(atIndex index: Int) {
        
        guard getLevel(atIndex: index) != nil else {return}
        
        stages[currentStage].levels[index].unlock()
        save()
    }
    
    /// Uses the hint on the current level.
    func useHint() {
        stages[currentStage].levels[currentLevel].useHint()
        save()
    }
    
    /// Sets the current level to completed and unlocks the next level.
    private func levelCompleted() {
        
        // Update and save singleImage correct count
        if level.isOnFirstImage {
            singleImageCorrect += 1
            UserDefaults.standard.setValue(singleImageCorrect, forKey: "singleImageCorrect")
        }
        
        stages[currentStage].levels[currentLevel].completed()
        unlockLevel(atIndex: currentLevel + 1)
        userInput = ""
        save()
    }
    
    //-------------------USER INPUT-----------------//
    // MARK: USER INPUT
    
    /// The user's input.
    var input: String {
        userInput
    }
    
    /// Adds a character to the current level artwork.
    func addCharacter() {
        stages[currentStage].levels[currentLevel].addCharacter()
        save()
    }
    
    /**
     Modifies the user's input by adding or deleting letters/spaces.
     - Parameters:
        - operation: The type of operation to perfrom.
        - letter: The letter to append to the user's input.
    */
    func updateInput(operation: EditOperation, _ letter: String = "") {
        
        /// Removes the last character in the users input.
        @discardableResult func delete() -> Character? {
            userInput.popLast()
        }
        
        switch operation {
        case .addLetter:
            userInput += letter
        case .delete:
            delete()
        case .space:
            userInput += " "
        }
    }
    
    /// Checks if the user's input is the correct answer to the current level.
    /// - Returns: `true` if the user's input is correct else `false`.
    func checkAnswer() -> Bool {
        
        if #available(iOS 16.0, *) {
            
            guard let regex = try? Regex(level.regex) else {return false}
            if (try? regex.firstMatch(in: userInput)) != nil {
                levelCompleted()
                return true
            }
            
        } else {
            
            guard let regex = try? NSRegularExpression(pattern: level.regex) else {return false}
            let range = NSRange(location: 0, length: userInput.utf16.count)
            
            if (regex.firstMatch(in: userInput, range: range)) != nil {
                levelCompleted()
                return true
            }
            
        }
        return false
    }
}
