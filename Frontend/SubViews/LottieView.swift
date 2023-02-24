// File: LottieView.swift
// Project: Persona Pop
// Purpose: Create the view for lottie animations to work
// Created by Reese Barnett on 5/31/22.
// Source: https://medium.com/swlh/how-to-use-lottie-animations-in-swiftui-caaf19944d96

import Foundation
import SwiftUI
import Lottie

/// A view that displays a lottie file.
struct LottieView: UIViewRepresentable {
    
    let name: String
    private var animationView: AnimationView
    
    init(name: String) {
        self.name = name
        animationView = AnimationView()
    }
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)
        
        animationView.animation = Animation.named(name)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.backgroundBehavior = .pauseAndRestore
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {}
}
