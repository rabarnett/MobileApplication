// File: UnlockLevelPopUp.swift
// Project: Persona Pop
// Purpose: Prompts the user to buy the level.
// Created by Reese Barnett on 12/25/22.

import SwiftUI

/// A view that displays a prompt to buy the level.
struct UnlockLevelPopUp: View {
    
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
                Text("Unlock Level?")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                HStack {
                    
                    Button {
                        // TODO: play fullscreen ad
                        audioModel.play(sound: .uiClick)
                    } label: {
                        ZStack {
                            ElementStyle(radius: button.radius, width: button.width, height: button.height)
                            
                            HStack {
                                //FIXME: Dynamic size
                                Image(systemName: "play.rectangle.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    
                    Button {
                        audioModel.play(sound: .uiClick)
                        buy()
                    } label: {
                        ZStack {
                            ElementStyle(radius: button.radius, width: button.width, height: button.height)
                            
                            HStack {
                                //FIXME: Dynamic size
                                Image("gem")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                
                                Text(coinModel.levelValue.gems, format: .number)
                                    .foregroundColor(.white)
                                    .font(.title2)
                            }
                        }
                    }
                }
            }
        }
    }
    
    /// Buys the item  and changes view to it, else displays insufficient coins.
    private func buy() {
        do {
            
            try coinModel.buy(.level, atIndex: index, with: .gems, gameModel: gameModel)
            
            viewRouter.toAnswerField(levelIndex: index, gameModel)
            
        } catch GameError.insufficientFunds {
            // TODO: Change view to store
        }catch{return}
    }
}

/// ``UnlockLevelPopUp`` preview for Xcode canvas simulator.
struct UnlockLevelPopUp_Previews: PreviewProvider {
    static var previews: some View {
        UnlockLevelPopUp(showPopUp: .constant(true), index: 1)
            .environmentObject(AudioController())
            .environmentObject(CoinController())
            .environmentObject(GameController())
    }
}
