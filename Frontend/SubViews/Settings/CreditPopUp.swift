// File: CreditPopUp.swift
// Project: Persona Pop
// Purpose: A view that displays the app credits
// Created by Reese Barnett on 6/28/22.

import SwiftUI

/// A view that displays the app credits pop up.
struct CreditPopUp: View {
    
    private let text = [
        "developer",
        "reese b\n",
        "artist",
        "jailyn s\n",
        "thank you",
        "jk kim\nicons8"
    ]
    private let popUp = LayoutSize.settingsPopUp
    @Binding var openCredit: Bool
    
    @EnvironmentObject var audioModel: AudioController
    
    var body: some View {
        VStack {
            ZStack {
                ElementStyle(radius: popUp.radius, width: popUp.width, height: popUp.height)
                
                VStack {
                    VStack {
                        ForEach(text, id: \.self) { line in
                            Text(line)
                        }
                    }
                    .foregroundColor(.white)
                    .font(Font.custom("MajorMonoDisplay-Regular", size: LayoutSize.creditFontSize))
                    .multilineTextAlignment(.center)
                    .frame(width: popUp.width)
                }
            }
            
            Button {
                audioModel.play(sound: .uiClick)
                openCredit = false
            } label: {
                CircleIcon(imageName: "x-sign")
            }
        }
    }
}

///``CreditPopUp`` preview for Xcode canvas simulator.
struct CreditPopUp_Previews: PreviewProvider {
    static var previews: some View {
        CreditPopUp(openCredit: .constant(true))
            .environmentObject(AudioController())
            .preferredColorScheme(.dark)
    }
}
