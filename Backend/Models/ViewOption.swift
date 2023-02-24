// File: ViewOption.swift
// Project: Persona Pop
// Purpose: View options the user can navigate to
// Created by Reese Barnett on 6/6/22.

import Foundation

/// A profile that specifies views that can be navigated to.
enum ViewOption {
    
    ///View that holds the play button and settings.
    case homeView
    
    ///View that holds the list of stages.
    case stageView
    
    ///View that holds the grid of levels
    case levelGrid
    
    ///View that holds the artwork and keyboard
    case answerField
}
