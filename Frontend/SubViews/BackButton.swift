// FIle: BackButton.swift
// Project: Persona Pop
// Purpose: Display a back button that can navigate to any view
// Created by Reese Barnett on 2/6/22.

import SwiftUI

/// A view that displays the back button.
struct BackButton: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var audioModel: AudioController
    
    var body: some View {
        
        Button {
            audioModel.play(sound: .uiClick)
            viewRouter.goBack()
        } label: {
            //TODO: Make dynamic offset
            CircleIcon(imageName: "back-arrow", offset: -2)
        }
    }
}

/// ``BackButton`` preview for Xcode canvas simulator.
struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        BackButton()
            .environmentObject(ViewRouter())
            .environmentObject(AudioController())
            .preferredColorScheme(.dark)
    }
}
