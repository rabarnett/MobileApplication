// File: SettingsIcon.swift
// Project: Persona Pop
// Purpose: A button that opens the settings to the app
// Created by Reese Barnett on 6/26/22.

import SwiftUI

/// A view that displays the settings gear.
struct SettingsIcon: View {
    
    private let icon = LayoutSize.settingsIcon
    @Binding var openSettings: Bool
    @Binding var openAudio: Bool
    @Binding var openSocial: Bool
    @Binding var openCredit: Bool
    
    @EnvironmentObject var audioModel: AudioController
    
    var body: some View {
        ZStack {
            
            SettingsOption(openPopUp: $openAudio, openSettings: $openSettings, imageName: "sound", delay: 0, offset: 0.75)
            
            SettingsOption(openPopUp: $openSocial, openSettings: $openSettings, imageName: "info", delay: 0.1, offset: 1.75)
            
            SettingsOption(openPopUp: $openCredit, openSettings: $openSettings, imageName: "credits", delay: 0.2, offset: 2.75)
            
            Button {
                openSettings.toggle()
                audioModel.play(sound: .uiClick)
            } label: {
                LottieView(name: "SettingsGear")
                    .frame(width: icon.width , height: icon.height)
            }
        }
    }
}

/// ``SettingsIcon`` preview for Xcode canvas simulator.
struct SettingsIcon_Previews: PreviewProvider {
    static var previews: some View {
        SettingsIcon(openSettings: .constant(false), openAudio: .constant(false), openSocial: .constant(false), openCredit: .constant(false))
            .environmentObject(AudioController())
            .preferredColorScheme(.dark)
    }
}
