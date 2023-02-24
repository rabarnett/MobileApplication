// File: UnlockStagePopUp.swift
// Project: Persona Pop
// Purpose: Prompts the user to buy a stage.
// Created by Reese Barnett on 2/15/23.

import SwiftUI

/// A view that displays a prompt to buy a stage.
struct UnlockStagePopUp: View {
    
    private let popUp = LayoutSize.correctPopUp
    private let button = LayoutSize.correctPopUpButton
    
    @Binding var showPopUp:Bool
    let index: Int
    
    @EnvironmentObject var audioModel: AudioController
    @EnvironmentObject var coinModel: CoinController
    @EnvironmentObject var gameModel: GameController
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        ZStack {
            ElementStyle(radius: popUp.radius, width: popUp.width, height: popUp.height)
            
            // Exit button
            Button {
                audioModel.play(sound: .uiClick)
                showPopUp = false
            } label: {
                ZStack {
                    // FIXME: Update with dynamic sizing
                    
                    ElementStyle(radius: 50, width: 50, height: 50)
                    
                    Text("x")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                }
            }
            .offset(x: -popUp.width/2.3, y: -popUp.height/2.3)
            
            VStack {
                Text("Unlock Stage?")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                HStack {
                    
                    Button {
                        audioModel.play(sound: .uiClick)
                        buy(with: .gems)
                    } label: {
                        ZStack {
                            ElementStyle(radius: button.radius, width: button.width, height: button.height)
                            
                            HStack {
                                //FIXME: Dynamic size
                                Image("gem")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                
                                Text(coinModel.stageValue.gems, format: .number)
                                    .foregroundColor(.white)
                                    .font(.title2)
                            }
                        }
                    }
                    
                    Button {
                        audioModel.play(sound: .uiClick)
                        buy(with: .coins)
                    } label: {
                        ZStack {
                            ElementStyle(radius: button.radius, width: button.width, height: button.height)
                            
                            HStack {
                                //FIXME: Dynamic size
                                Image("CoinStack")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                
                                Text(coinModel.stageValue.coins, format: .number)
                                    .foregroundColor(.white)
                                    .font(.title2)
                            }
                        }
                    }
                }
            }
        }
    }
    
    /// Buys the item  and changes view to it, else displays insufficient coins
    /// - Parameter currency: The currency used to buy the stage.
    private func buy(with currency: CoinModel.Currency) {
        do {
            
            if currency == .gems {
                try coinModel.buy(.stage, atIndex: index, with: .gems, gameModel: gameModel)
            } else {
                try coinModel.buy(.stage, atIndex: index, with: .gems, gameModel: gameModel)
            }
            
            try viewRouter.toLevelsView(stageIndex: index, gameModel)
            
        } catch GameError.insufficientFunds {
            // TODO: Change view to store
        }catch{return}
    }
}

/// ``UnlockStagePopUp`` preview for Xcode canvas simulator.
struct UnlockStagePopUp_Previews: PreviewProvider {
    static var previews: some View {
        UnlockStagePopUp(showPopUp: .constant(true), index: 1)
    }
}
