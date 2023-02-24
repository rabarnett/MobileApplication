// File: LevelIcon.swift
// Project: Persona Pop
// Purpose: Displays the level number
// Created by Reese Barnett on 2/5/22.

import SwiftUI

/// A view that displays the level icon.
struct LevelIcon: View {
    
    let levelNumber: Int
    let isCorrect: Bool
    let color: String
    let isLocked: Bool
    private let icon = LayoutSize.levelIcon
    
    var body: some View {
        ZStack {
            ElementStyle(radius: icon.radius, width: icon.width, height: icon.height, color: color, outlineColor: isCorrect ? .yellow: .white)
            
            if isLocked {
                RoundedRectangle(cornerRadius: icon.radius)
                    .frame(width: icon.height, height: icon.width)
                    .foregroundColor(.black)
                    .opacity(0.3)
                
                Image("lock")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60) //FIXME: Dynamic size
            } else {
                Text("\(levelNumber)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
        }
    }
}

/// ``LevelIcon`` preview for Xcode canvas simulator.
struct LevelIcon_Previews: PreviewProvider {
    static var previews: some View {
        LevelIcon(levelNumber: 1, isCorrect: false, color: "Purple", isLocked: true)
            .preferredColorScheme(.dark)
    }
}
