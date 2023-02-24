// File: HintPopUp.swift
// Project: Persona Pop
// Purpose: Displays the hint.
// Created by Reese Barnett on 1/8/23.

import SwiftUI

struct HintPopUp: View {
    
    private let popUp = LayoutSize.correctPopUp
    private let button = LayoutSize.correctPopUpButton
    
    @State private var noHints: Bool = false
    @Binding var showHint: Bool
    
    @EnvironmentObject var gameModel: GameController
    @EnvironmentObject var coinModel: CoinController
    
    var body: some View {
        ZStack {
            ElementStyle(radius: popUp.radius, width: popUp.width, height: popUp.height)
            
            VStack() {
                Text(noHints ? "No Hints" : gameModel.level.hint)
                    .foregroundColor(.white)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .frame(width: popUp.width - 5)
                    .padding(.bottom)
                
                Button {
                    showHint = false
                } label: {
                    ZStack {
                        ElementStyle(radius: button.radius, width: button.width, height: button.height)
                        
                        Text("Back")
                            .foregroundColor(.white)
                            .font(.title2)
                    }
                }
            }
        }
        .onAppear {
            do {
                try coinModel.removeHint(gameModel)
            }catch GameError.insufficientHints {
                noHints = true
            }catch{}
        }
    }
}

struct HintPopUp_Previews: PreviewProvider {
    static var previews: some View {
        HintPopUp(showHint: .constant(false))
            .preferredColorScheme(.dark)
    }
}
