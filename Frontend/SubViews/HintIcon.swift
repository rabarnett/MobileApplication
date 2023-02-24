// File: HintIcon.swift
// Project: Persona Pop
// Purpose: Display the hint icon
// Created by Reese Barnett on 1/8/23.

import SwiftUI

/// A view that displays the hint button.
struct HintIcon: View {
    
    let hintNum: Int
    let hintUsed: Bool
    @Binding var showHint: Bool
    
    var body: some View {
        Button {
            // Only opens the popUp
            // The popUp calls relevant funcs
            showHint = true
        } label: {
            ZStack {
                // TODO: Add dynamic sizing
                ElementStyle(radius: 15, width: 50, height: 50, color: "Purple", outlineColor: hintUsed ? .yellow : .white)
                
                Image(hintUsed ? "hintUsed" : "hint")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45, height: 45)
                
                if !hintUsed {
                    ZStack {
                        Circle()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.red)
                        
                        Text(hintNum, format: .number)
                            .foregroundColor(.white)
                            .font(.subheadline)
                            .bold()
                    }
                    .offset(x: 22, y: -23)
                }
            }
        }

    }
}

/// ``HintIcon`` preview for Xcode canvas simulator.
struct HintIcon_Previews: PreviewProvider {
    static var previews: some View {
        HintIcon(hintNum: 3, hintUsed: false, showHint: .constant(false))
            .preferredColorScheme(.dark)
    }
}
