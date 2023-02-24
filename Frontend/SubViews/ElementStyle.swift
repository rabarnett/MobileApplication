// File: ElementStyle.swift
// Project: Persona Pop
// Purpose: Provides the shape and style of app elements
// Created by Reese Barnett on 5/31/22.

import SwiftUI

/// A view that provides the shape and style of various UI elements.
struct ElementStyle: View {
    
    let radius: CGFloat
    let width: CGFloat
    let height: CGFloat
    let color: String
    let outlineColor: Color
    
    init(radius: CGFloat, width: CGFloat, height: CGFloat, color: String, outlineColor: Color) {
        self.radius = radius
        self.width = width
        self.height = height
        self.color = color
        self.outlineColor = outlineColor
    }
    
    init(radius: CGFloat, width: CGFloat, height: CGFloat) {
        self.radius = radius
        self.width = width
        self.height = height
        self.color = "Accent"
        self.outlineColor = .white
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: radius)
            .frame(width: width, height: height)
            .foregroundColor(Color(color))
            .overlay {
                RoundedRectangle(cornerRadius: radius)
                    .stroke(lineWidth: 2)
                    .foregroundColor(outlineColor)
                    
            }
    }
}

/// ``ElementStyle`` preview for Xcode canvas simulator.
struct ElementStyle_Previews: PreviewProvider {
    static var previews: some View {
        ElementStyle(radius: 10, width: 100, height: 100)
            .preferredColorScheme(.dark)
    }
}
