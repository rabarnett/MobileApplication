// File: StageView.swift
// Project: Persona Pop
// Purpose: Display stages and navigation to associated levels
// Created by Reese Barnett on 2/6/22.

import SwiftUI

/// A view that displays the stages.
struct StageView: View {
    
    @State private var page = 0
    @State private var showPopUp = false
    @State private var selectedStageIndex: Int!
    
    @EnvironmentObject var gameModel: GameController
    @EnvironmentObject var audioModel: AudioController
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var coinModel: CoinController
    
    var body: some View {
        
        ZStack {
            TabView(selection: $page) {
                ForEach(0...gameModel.numStages - 1, id: \.self) { i in
                    
                    let stage = gameModel.getStage(atIndex: i)!
                    
                    Button {
                        audioModel.play(sound: .uiClick)
                        selectedStageIndex = i
                        openStage(i)
                                                
                    } label: {
                        ZStack {
                            let view = StageIcon(stage: stage, isShowing: page == i)
                            
                            if stage.isLocked {
                                LockedStage(view: view, cost: coinModel.stageValue.coins)
                            } else {
                                view
                            }
                        }
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .animation(.spring(response: 0.5, dampingFraction: 0.4), value: page)
            
            if showPopUp {
                UnlockStagePopUp(showPopUp: $showPopUp, index: selectedStageIndex)
            }
        }
        .animation(.easeOut(duration: 0.5), value: showPopUp)
        .onAppear {
            page = gameModel.stage.id
        }
    }
    
    /**
     Opens the stage if possible, else prompts user to buy.
     - Parameter index: The index of the stage in the `stages` array.
     - Note: A stage's `id` is equal to its index in `stages`.
    */
    private func openStage(_ index: Int) {
        do {
            try viewRouter.toLevelsView(stageIndex: index, gameModel)
            
        } catch GameError.lockedStage {
            showPopUp = true
        } catch {return}
    }
}

/// ``StageView`` preview for Xcode canvas simulator.
struct StageView_Previews: PreviewProvider {
    static var previews: some View {
        StageView()
            .environmentObject(GameController())
            .environmentObject(CoinController())
            .environmentObject(AudioController())
            .environmentObject(ViewRouter())
    }
}
