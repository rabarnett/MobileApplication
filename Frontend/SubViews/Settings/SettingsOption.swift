// File: SettingsOption.swift
// Project: Persona Pop
// Purpose: A view that displays a setting option icon
// Created by Reese Barnett on 6/27/22.

import SwiftUI

/// A view that displays a settings "bubble" icon (travels out of the settings icon).
struct SettingsOption: View {
    
    @Binding var openPopUp: Bool
    @Binding var openSettings: Bool
    let imageName: String
    let delay: Double
    let offset: Double
    private let width = LayoutSize.width
    
    @EnvironmentObject var audioModel: AudioController
    
    var body: some View {
        
        Button {
            audioModel.play(sound: .uiClick)
            openPopUp = true
            openSettings = false
        } label: {
            CircleIcon(imageName: imageName)
        }
        .scaleEffect(openSettings ? 1:0.000001) //Value of "0" fills console with warnings
        .offset(x: openSettings ?(offset * width * 0.28):0)
        .animation(
            .spring(response: 0.4, dampingFraction: 0.5)
            .delay(delay),
            value: openSettings
        )
    }
}

/// ``SettingsOption`` preview for Xcode canvas simulator.
struct SettingsOption_Previews: PreviewProvider {
    static var previews: some View {
        SettingsOption(openPopUp: .constant(false), openSettings: .constant(true), imageName: "music", delay: 0, offset: 0)
            .environmentObject(AudioController())
            .preferredColorScheme(.dark)
    }
}
