// File: ViewRouter.swift
// Project: Persona Pop
// Purpose: Controls what view should be showing
// Created by Reese Barnett on 2/6/22.

import Foundation

/// Manages what view should be showing.
final class ViewRouter: ObservableObject {
    
    /// The current view being dispalyed.
    @Published private(set) var currentView: ViewOption = .homeView
    
    /// The value is the view right before the key.
    private let previous: [ViewOption: ViewOption] = [
        .homeView : .homeView,
        .stageView : .homeView,
        .levelGrid : .stageView,
        .answerField : .levelGrid
    ]
    
    /// Changes the current view to ``HomeView``.
    func toHomeView() {
        currentView = .homeView
    }
    
    /// Changes the current view to ``StageView``.
    func toStagesView() {
        currentView = .stageView
    }
    
    /**
     Changes the current view to ``LevelGrid``.
     - Parameters:
        - index: The index of the stage in the `stages` array.
        - gameModel: Sets the stage that will be navigated to.
     - Throws: ``GameError/lockedStage``.
     - Note: A stage's `id` is equal to its index in `stages`.
    */
    func toLevelsView(stageIndex index: Int, _ gameModel: GameController) throws {
        try gameModel.setStage(to: index)
        currentView = .levelGrid
    }
    
    /**
     Changes the current view to ``AnswerField``.
     - Parameters:
        - index: The index of the level in the ``Stage/levels`` array.
        - gameModel: Sets the level that will be navigated to.
     - Attention: A level's `id`  is NOT equal to its index in the ``Stage/levels`` array.
    */
    func toAnswerField(levelIndex index: Int, _ gameModel: GameController) {
        do {
            try gameModel.setLevel(to: index)
        } catch{return}
        currentView = .answerField
    }
    
    /// Updates the current view to the previous view
    func goBack() {
        currentView = previous[currentView] ?? .homeView
    }
}
