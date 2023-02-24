// File: StageTitle.swift
// Project: Persona Pop
// Purpose: Displays the title of the stage
// Created by Reese Barnett on 5/31/22.

import SwiftUI

/// A view that displays the title of the stage.
struct StageTitle: View {
    
    let text: String
    private let title = LayoutSize.stageTitle
    
    var body: some View {
        ZStack {
            ElementStyle(radius: title.radius, width: title.width, height: title.height)
            Text(text)
                .foregroundColor(.white)
                .font(Font.custom("MajorMonoDisplay-Regular", size: title.fontSize))
        }
    }
}

/// ``StageTitle`` preview for Xcode canvas simulator.
struct StageTitle_Previews: PreviewProvider {
    static var previews: some View {
        StageTitle(text: "tV shows")
    }
}
