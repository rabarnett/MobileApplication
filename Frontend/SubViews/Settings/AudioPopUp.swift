// File: AudioPopUp.swift
// Project: Persona Pop
// Purpose: A view that displays the audio settings
// Created by Reese Barnett on 6/28/22.

import SwiftUI

/// A view that displays the audio settings pop up.
struct AudioPopUp: View {
    
    private let popUp = LayoutSize.settingsPopUp
    
    @State private var musicOn = AudioController().sound.musicOn
    @State private var effectsOn = AudioController().sound.effectsOn
    @State private var hapticsOn = AudioController().sound.hapticsOn
    
    @Binding var openAudio: Bool
    
    @EnvironmentObject var audioModel: AudioController
    
    var body: some View {
        VStack {
            ZStack {
                ElementStyle(radius: popUp.radius, width: popUp.width, height: popUp.height)
                VStack(alignment: .trailing) {
                    AudioRow(
                        value: $musicOn,
                        imageName: musicOn ? "music-on" : "music-off",
                        text: "Music",
                        audioFunction: audioModel.toggleMusic,
                        controlName: "Music"
                    )
                        .padding()
                    
                    AudioRow(
                        value: $effectsOn,
                        imageName: effectsOn ? "effects-on" : "effects-off",
                        text: "effects",
                        audioFunction: audioModel.toggleEffects,
                        controlName: "Sound\nEffects"
                    )
                        .padding()
                    
                    AudioRow(
                        value: $hapticsOn,
                        imageName: hapticsOn ? "vibration-on" : "vibration-off",
                        text: "VibRAtion",
                        audioFunction: audioModel.toggleHaptics,
                        controlName: "Vibration"
                    )
                        .padding()
                }
            }
            
            Button {
                openAudio = false
                audioModel.play(sound: .uiClick)
            } label: {
                CircleIcon(imageName: "x-sign")
            }
        }
    }
}

/// ``AudioPopUp`` preview for Xcode canvas simulator.
struct AudioPopUp_Previews: PreviewProvider {
    static var previews: some View {
        AudioPopUp(openAudio: .constant(true))
            .environmentObject(AudioController())
            .preferredColorScheme(.dark)
    }
}

/// A view that displays a row in ``AudioPopUp``.
struct AudioRow: View {
    
    @Binding var value: Bool
    let imageName: String
    let text: String
    let audioFunction: () -> ()
    private let image = LayoutSize.audioImage
    let controlName: String
    
    var body: some View {
        
        HStack(spacing: image.spacing) {
            
            Text(controlName)
                .foregroundColor(.white)
                .font(.title3)
            
            Image(imageName)
                .resizable()
                .frame(width:image.width, height: image.height)
            
            Toggle("Toggle Value", isOn: $value)
                .toggleStyle(.switch)
                .labelsHidden()
                .onChange(of: value) { _ in
                    audioFunction()
                }
        }
    }
    
}
