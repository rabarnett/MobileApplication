// File: AnswerField.swift
// Project: Persona Pop
// Purpose: Display artwork and provide user input
// Created by Reese Barnett on 2/5/22.

import SwiftUI

/// A view that displays the artwork and keyboard.
struct AnswerField: View {
    
    @State private var levelComplete = false
    @State private var popUpHidden = true
    @State private var showHint = false
    @State private var onFirstImage = true
    
    @EnvironmentObject var gameModel: GameController
    @EnvironmentObject var coinModel: CoinController
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var audioModel: AudioController
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            ZStack {
                
                VStack {
                    
                    Artwork()
                        .animation(.easeIn(duration: 1), value: levelComplete)
                    
                    if !gameModel.level.isCorrect {
                        CharacterCounter(showHint: $showHint)
                                .padding()
                    }
                    
                    KeyBoard(levelCompleted: $levelComplete, hideKeyboard: gameModel.level.isCorrect)
                        .padding([.top, .bottom])
                }
                
                if showHint {
                    HintPopUp(showHint: $showHint)
                }
            }
            
            // Controls when the pop up should show and hide
            if levelComplete && popUpHidden {
                
                CorrectAnswerPopUp(isShowing: $popUpHidden)
                    .onAppear {
                        audioModel.play(sound: .levelWin)
                        coinModel.coinsWon(gameModel.level.winAmount)
                    }
                    .onDisappear {
                        levelComplete = false
                        popUpHidden = true
                    }
            }
            Spacer()
        }
        .animation(.spring(response: 0.5, dampingFraction: 0.6), value: levelComplete)
        .animation(.spring(response: 1, dampingFraction: 0.5), value: popUpHidden)
    }
}

/// ``AnswerField`` preview for Xcode canvas simulator.
struct AnswerField_Previews: PreviewProvider {
    static var previews: some View {
        AnswerField()
            .environmentObject(GameController())
            .environmentObject(CoinController())
            .environmentObject(ViewRouter())
            .environmentObject(AudioController())
            .preferredColorScheme(.dark)
    }
}
