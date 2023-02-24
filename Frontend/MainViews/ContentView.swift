// File: ContentView.swift
// Project: Persona Pop
// Purpose: A view that houses all views for easier navigation
// Created by Reese Barnett on 2/5/22.

import SwiftUI

/// A view that displays any selected "main" view.
struct ContentView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var audioModel: AudioController
    @EnvironmentObject var coinModel: CoinController
    
    var body: some View {
        ZStack {
            
            LottieView(name: "forestBackground")
                .scaledToFill()
                .frame(width: LayoutSize.width)
                .edgesIgnoringSafeArea(.all)
                
            VStack {
                
                if viewRouter.currentView != .homeView {
                    HStack {
                        BackButton()
                        Spacer()
                        ItemBar(totalCoins: coinModel.coins, totalGems: coinModel.gems)
                    }
                    .padding([.trailing, .leading])
                }
                
                switch viewRouter.currentView {
                    case .homeView:
                        HomeView()
                    case .stageView:
                        StageView()
                    case .levelGrid:
                        LevelGrid()
                    case .answerField:
                        AnswerField()
                }
            }
        }
        .statusBar(hidden: true)
        .animation(.easeIn(duration: 0.3), value: viewRouter.currentView)
        .onAppear {
            audioModel.play(sound: .background)
            NotificationModel.removeBadge()
        }
        .task {
            await NotificationModel.check()
        }
    }
}

/// ``ContentView`` preview for Xcode canvas simulator.
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(GameController())
            .environmentObject(CoinController())
            .environmentObject(AudioController())
            .environmentObject(ViewRouter())
    }
}
