// File: CorrectAnswerPopUp.swift
// Project: Persona Pop
// Purpose: Displays a view that communicates the answer is correct
// Created by Reese Barnett on 2/5/22.

import SwiftUI

/// A view that displays pop up stating the answer is correct.
struct CorrectAnswerPopUp: View {
    
    private let popUp = LayoutSize.correctPopUp
    private let button = LayoutSize.correctPopUpButton
    private let image = LayoutSize.correctPopUpImage
    
    @Binding var isShowing: Bool
    
    @EnvironmentObject var gameModel: GameController
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var audioModel: AudioController
    
    var body: some View {
        ZStack {
            ElementStyle(radius: popUp.radius, width: popUp.width, height: popUp.height)
            
            VStack {
                Text("Correct!")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                
                HStack(spacing:0) {
                    
                    Text("+\(gameModel.level.winAmount)")
                        .foregroundColor(.white)
                        .font(.title)
                    
                    Image("CoinStack")
                        .resizable()
                        .frame(width: image.width, height: image.height)
                }
                
                HStack {
                    Button {
                        audioModel.play(sound: .uiClick)
                        isShowing = false
                    } label: {
                        ZStack {
                            ElementStyle(radius: button.radius, width: button.width, height: button.height)
                            Text("View")
                                .foregroundColor(.white)
                                .font(.title2)
                        }
                    }
                    
                    Button {
                        audioModel.play(sound: .uiClick)
                        isShowing = false
                        gameModel.moveOn(viewRouter)
                    } label: {
                        ZStack {
                            ElementStyle(radius: button.radius, width: button.width, height: button.height)

                            Text("Next")
                                .foregroundColor(.white)
                                .font(.title2)
                        }
                    }
                }
            }
        }
    }
}

/// ``CorrectAnswerPopUp`` preview for Xcode canvas simulator.
struct CorrectAnswerPopUp_Previews: PreviewProvider {
    static var previews: some View {
        CorrectAnswerPopUp(isShowing: .constant(false))
            .environmentObject(GameController())
            .environmentObject(ViewRouter())
            .environmentObject(AudioController())
    }
}
