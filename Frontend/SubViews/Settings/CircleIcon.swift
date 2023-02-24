// File: CircleIcon.swift
// Project: Persona Pop
// Purpose: A view that displays a circle icon
// Created by Reese Barnett on 6/28/22.

import SwiftUI

/// A view that displays a circle icon (used throughout settings).
struct CircleIcon: View {
    
    let imageName: String
    let offset: CGFloat
    private let circle = LayoutSize.settingsCircle
    
    init(imageName: String, offset: CGFloat) {
        self.imageName = imageName
        self.offset = offset
    }
    
    init(imageName: String) {
        self.imageName = imageName
        self.offset = 0
    }
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: circle.icon_width, height: circle.icon_height)
                .foregroundColor(Color("Accent"))
                .overlay {
                    Circle()
                        .stroke(lineWidth: 2)
                        .foregroundColor(.white)
                }
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: circle.image_width, height: circle.image_height)
                .offset(x:offset, y: offset)
        }
    }
}

/// ``CircleIcon`` preview for Xcode canvas simulator.
struct CircleIcon_Previews: PreviewProvider {
    static var previews: some View {
        CircleIcon(imageName: "music")
            .preferredColorScheme(.dark)
    }
}
