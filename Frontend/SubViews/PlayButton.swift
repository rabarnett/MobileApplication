// File: PlayButton.swift
// Project: Persona Pop
// Purpose: The play button lable
// Created by Reese Barnett on 6/26/22.

import SwiftUI

/// A view that displays the play button.
struct PlayButton: View {
    
    let text: String
    
    var body: some View {
        ZStack {
            ElementStyle(radius: LayoutSize.playButton.radius, width: LayoutSize.playButton.width, height: LayoutSize.playButton.height)
            
            Text(text)
                .font(Font.custom("MajorMonoDisplay-Regular", size: LayoutSize.playButton.textSize))
                .foregroundColor(.white)
        }
    }
}

/// ``PlayButton`` preview for Xcode canvas simulator.
struct PlayButton_Previews: PreviewProvider {
    static var previews: some View {
        PlayButton(text: "PLAY")
    }
}
