// File: LockedStage.swift
// Project: Persona Pop
// Purpose:
// Created by Reese Barnett on 7/11/22.

import SwiftUI

/// A view that displays a locked stage icon.
struct LockedStage: View {
    
    let view: StageIcon
    let cost: Int
    private let text = LayoutSize.stageCardText
    private let coinStack = LayoutSize.payWallCoinStack
    private let card = LayoutSize.stageCard
    
    var body: some View {
        ZStack {
            
            view.blur(radius: 3)
            
            VStack {
                
                Text(view.stage.name)
                    .font(Font.custom("MajorMonoDisplay-Regular", size: text.size1))
                    .foregroundColor(.white)
                
                HStack {
                    
                    Image("CoinStack")
                        .resizable()
                        .frame(width: coinStack.width, height: coinStack.height)
                    
                    Text("\(cost)")
                        .foregroundColor(.white)
                    .font(.largeTitle)
                }
            }
            .offset(y: card.offset)
        }
    }
}

///``LockedStage`` for Xcode canvas simulator.
struct LockedStage_Previews: PreviewProvider {
    static var previews: some View {
        let level = Level(id: 101, imageNames: [], answer: "", regex: "",isCorrect: false, currentImageIndex: 0, winAmount: 0, isLocked: false, usedHint: false)
        
        let stage = Stage(id: 0, name: "shows 1", color: "Purple", levels: [level], isLocked: false)
        
        LockedStage(view: StageIcon(stage: stage, isShowing: true), cost: 1000)
            .preferredColorScheme(.dark)
    }
}
