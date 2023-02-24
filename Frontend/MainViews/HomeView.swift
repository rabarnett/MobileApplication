// File: HomeView.swift
// Project: Persona Pop
// Purpose: Display opening view for app and houses the settings
// Created by Reese Barnett on 2/6/22.

import SwiftUI

/// A view that displays the start screen and settings.
struct HomeView: View {
    
    @State private var openSettings = false
    @State private var openAudio = false
    @State private var openSocial = false
    @State private var openCredit = false
    @State private var buttonText = "PLAY"
    
    private var popUpIsOpen: Bool {
        openAudio || openSocial || openCredit
    }
    
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var audioModel: AudioController
    
    var body: some View {
        VStack {
            
            Spacer()
            
            Text("peRsonA pop")
                .font(Font.custom("MajorMonoDisplay-Regular", size: LayoutSize.titleFontSize))
                .foregroundColor(Color("Purple"))
            
            Spacer()
            
            Button {
                guard !popUpIsOpen else {return}
                audioModel.play(sound: .uiClick)
                viewRouter.toStagesView()
                
            } label: {
                PlayButton(text: getText())
                    .offset(y: LayoutSize.playButton.offset)
            }
            .buttonStyle(.plain)
            .animation(
                .spring(response: 0.5, dampingFraction: 0.8), value: [openAudio, openSocial, openCredit]
            )
            
            
            if openAudio {
                AudioPopUp(openAudio: $openAudio)
            } else if openSocial {
                SocialPopUp(openSocial: $openSocial)
            } else if openCredit {
                CreditPopUp(openCredit: $openCredit)
            } else {
                Spacer()
            }
            
            HStack {
                
                SettingsIcon(openSettings: $openSettings, openAudio: $openAudio, openSocial: $openSocial, openCredit: $openCredit)
                    .disabled(popUpIsOpen)
                
                Spacer()
            }
        }
        .animation(
            .spring(response: 0.5, dampingFraction: 0.6), value: [openAudio, openSocial, openCredit]
        )
    }
    
    /// Gets the text that should be displayed on the play button.
    /// - Returns: The relevant text.
    private func getText() -> String {
        
        var text = "PLAY"
        
        if openAudio {
            text = "Audio"
        } else if openSocial {
            text = "sociAl"
        } else if openCredit {
            text = "cRedit"
        }
        
        return text
    }
}

/// ``HomeView`` preview for Xcode canvas simulator.
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ViewRouter())
            .environmentObject(AudioController())
            .preferredColorScheme(.dark)
    }
}
