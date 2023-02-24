// File: StageIcon.swift
// Project: Persona Pop
// Purpose: Displays the icon used to represent a stage
// Created by Reese Barnett on 6/5/22.

import SwiftUI

/// A view that displays a stages icon.
struct StageIcon: View {
    
    let stage: Stage
    let isShowing: Bool
    private let text = LayoutSize.stageCardText
    private let card = LayoutSize.stageCard
    
    private var width: CGFloat {
        isShowing ? card.l_width : card.s_width
    }
    
    private var height: CGFloat {
        isShowing ? card.l_height : card.s_height
    }
    
    var body: some View {
        ZStack {
            ElementStyle(radius: card.radius, width: width, height: height, color: stage.color, outlineColor: stage.percentComplete == 100 ? .yellow : .white)
                .shadow(color: Color(white: 0, opacity: 0.8), radius: 15, x: 10, y: 10)
            VStack {
                Text(stage.name)
                    .font(Font.custom("MajorMonoDisplay-Regular", size: text.size1))
                
                HStack {
                    Text("\(stage.numLevelsComplete)/\(stage.levelCount)")
                    Text("|")
                    Text("\(stage.percentComplete)%")
                }
                .font(Font.custom("MajorMonoDisplay-Regular", size: text.size2))
                .padding(.top)
            }
            .foregroundColor(.white)
        }
        .frame(width: UIScreen.main.bounds.width)
        .offset(y: card.offset)
    }
}

///``StageIcon`` preview for Xcode canva simulator.
struct StageIcon_Previews: PreviewProvider {
    static var previews: some View {
        let level = Level(id: 101, imageNames: [], answer: "", regex: "", isCorrect: false, currentImageIndex: 0, winAmount: 0, isLocked: false, usedHint: false)
        let stage = Stage(id: 0, name: "shows 1", color: "Purple", levels: [level], isLocked: false)
        StageIcon(stage: stage, isShowing: true)
    }
}
