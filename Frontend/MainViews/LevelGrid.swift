// File: LevelGrid.swift
// Project: Persona Pop
// Purpose: Display levels and navigation to associated answer field
// Created by Reese Barnett on 2/5/22.

import SwiftUI

/// A view that displays the levels.
struct LevelGrid: View {
    
    private var columns = Array(repeating: GridItem(.fixed(LayoutSize.width * 0.25)), count: 3)
    
    @State private var showPopUp: Bool = false
    @State private var selectedLevelIndex: Int!
    
    @EnvironmentObject var gameModel: GameController
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var audioModel: AudioController
    
    var body: some View {
        ZStack {
            VStack {
                
                StageTitle(text: gameModel.stage.name)
                    .padding()
                
                LazyVGrid(columns: columns) {
                    ForEach(0...gameModel.stage.levelCount - 1, id: \.self) { i in
                        
                        let level = gameModel.getLevel(atIndex: i)!
                        
                        Button {
                            
                            audioModel.play(sound: .uiClick)
                            selectedLevelIndex = i
                            
                            if level.isLocked {
                                showPopUp = true
                            } else {
                                viewRouter.toAnswerField(levelIndex: i, gameModel)
                            }
                            
                        } label: {
                            LevelIcon(levelNumber: i+1, isCorrect: level.isCorrect, color: gameModel.stage.color, isLocked: level.isLocked)
                                .padding()
                        }
                    }
                }
                .padding(.top)
                
                Spacer()
            }
            
            if showPopUp {
                UnlockLevelPopUp(showPopUp: $showPopUp, index: selectedLevelIndex)
            }
        }
        .animation(.easeOut(duration: 0.5), value: showPopUp)
    }
}

/// ``LevelGrid`` preview for Xcode canvas simulator.
struct LevelGrid_Previews: PreviewProvider {
    static var previews: some View {
        LevelGrid()
            .environmentObject(GameController())
            .environmentObject(CoinController())
            .environmentObject(ViewRouter())
            .environmentObject(AudioController())
    }
}
