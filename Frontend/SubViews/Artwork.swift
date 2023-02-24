// File: Artwork.swift
// Project: Persona Pop
// Purpose: Display the proper image upon click
// Created by Reese Barnett on 2/5/22.

import SwiftUI

/// A view that displays the character art.
struct Artwork: View {
    
    private let art = LayoutSize.artwork
    private let touch = LayoutSize.touchLottie
    @EnvironmentObject var gameModel: GameController
    @EnvironmentObject var coinModel: CoinController
    
    var body: some View {
        ZStack {
            
            Image(gameModel.level.currentImage)
                .resizable()
                .frame(width: art.width, height: art.height)
                .clipShape(RoundedRectangle(cornerRadius: art.radius))
                .overlay{
                    RoundedRectangle(cornerRadius: art.radius)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.white)
                }
                .shadow(color: Color(white: 0, opacity: 0.5), radius: 10, x: -15, y: 15)
                .disabled(gameModel.level.isCorrect)
            
            if gameModel.showTutorial{
                LottieView(name: "touch")
                    .frame(width: touch.width, height: touch.height)
            }
        }
        .onTapGesture {
            gameModel.addCharacter()
            coinModel.updateWinAmount(gameModel)
        }
        .animation(.easeIn(duration: 0.5), value: gameModel.level.currentImageIndex)
    }
}

/// ``Artwork`` preview for Xcode canvas simulator.
struct Artwork_Previews: PreviewProvider {
    static var previews: some View {
        Artwork()
            .environmentObject(GameController())
    }
}
