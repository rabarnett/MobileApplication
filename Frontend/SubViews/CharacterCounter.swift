// File: CharacterCounter.swift
// Project: Persona Pop
// Purpose: Display how many characters the user has displayed
// Created by Reese Barnett on 5/27/22.

import SwiftUI

/// A view that displays circle indicators for the number of characters showing.
struct CharacterCounter: View {
    
    @Binding var showHint: Bool
    @EnvironmentObject var gameModel: GameController
    @EnvironmentObject var coinModel: CoinController
    
    var body: some View {
        
        HStack {
            ForEach(0...gameModel.level.numberImages - 1, id: \.self) { i in
                CircleIndicator(fill: i <= gameModel.level.currentImageIndex)
            }
        }
        .overlay(alignment: .trailing) {
            HintIcon(hintNum: coinModel.hints, hintUsed: gameModel.level.usedHint, showHint: $showHint)
                .offset(x: 60)
        }
    }
}

/// ``CharacterCounter`` preview for Xcode canvas simulator.
struct CharacterCounter_Previews: PreviewProvider {
    static var previews: some View {
        CharacterCounter(showHint: .constant(false))
            .environmentObject(GameController())
            .environmentObject(CoinController())
            .preferredColorScheme(.dark)
    }
}

/// A view that displays a single filled/unfilled circle for ``CharacterCounter``.
struct CircleIndicator: View {
    
    let fill: Bool
    private let circle = LayoutSize.circleIndicator
    
    var body: some View {
        Circle()
            .frame(width: circle.width , height: circle.height)
            .foregroundColor(fill ? Color("Accent") : .clear)
            .overlay {
                Circle()
                    .stroke(lineWidth: 2)
                    .foregroundColor(.white)
            }
    }
}
