// File: SocialPopUp.swift
// Project: Persona Pop
// Purpose: A view that displays the social links
// Created by Reese Barnett on 6/28/22.

import SwiftUI

/// A view that displays the social links pop up.
struct SocialPopUp: View {
    
    private let popUp = LayoutSize.settingsPopUp
    
    @State private var showMail = false
    
    @Binding var openSocial: Bool
    
    @EnvironmentObject var audioModel: AudioController
    
    var body: some View {
        VStack {
            ZStack {
                ElementStyle(radius: popUp.radius, width: popUp.width, height: popUp.height)
                
                VStack(alignment:.leading) {
                    
                    Link(destination: SocialLink.instagram) {
                        SocialRow(imageName: "instagram", text: "instAgRAm")
                    }
                    .padding()

                    Link(destination: SocialLink.facebook) {
                        SocialRow(imageName: "facebook", text: "fAcebook")
                    }
                    .padding()

                    Button {
                        showMail.toggle()
                    } label: {
                        SocialRow(imageName: "suppourt", text: "suppoRt")
                    }
                    .padding()
                    .disabled(!MailView.canSendMail)
                    .sheet(isPresented: $showMail) {
                        MailView() {result in}
                    }
                }
            }
            
            Button {
                audioModel.play(sound: .uiClick)
                openSocial = false
            } label: {
                CircleIcon(imageName: "x-sign")
            }
        }
    }
}

/// ``SocialPopUp`` preview for Xcode canvas simulator.
struct SocialPopUp_Previews: PreviewProvider {
    static var previews: some View {
        SocialPopUp(openSocial: .constant(true))
            .environmentObject(AudioController())
            .preferredColorScheme(.dark)
    }
}

/// A view that displays a row in ``SocialPopUp``.
struct SocialRow: View {
    
    let imageName: String
    let text: String
    private let font = LayoutSize.socialFont
    private let imageSize = LayoutSize.socialImage
    
    var body: some View {
        
        HStack {
            Image(imageName)
                .resizable()
                .frame(width: imageSize.width, height: imageSize.height)
            
            Text(text)
                .foregroundColor(.white)
                .font(Font.custom("MajorMonoDisplay-Regular", size: font.size))
                .padding(.leading, font.spacing)
        }
    }
}
