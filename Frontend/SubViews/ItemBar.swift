// File: ItemBar.swift
// Project: Persona Pop
// Purpose: Display the total coins the user has
// Created by Reese Barnett on 5/27/22.

import SwiftUI

/// A view that displays the total coins the user has.
struct ItemBar: View {
    
    let totalCoins: Int
    let totalGems: Int
    private let layout = LayoutSize.totalCoins
    
    var body: some View {
        ZStack {
            ElementStyle(radius: layout.radius, width: layout.width, height: layout.height)
            HStack(spacing: 0) {
                
                Image("gem")
                    .resizable()
                    .frame(width: layout.image_width, height: layout.image_height)
                
                Text(totalGems, format: .number)
                    .foregroundColor(.white)
                    .font(.title3)
                    .padding(.trailing)
                
                Image("CoinStack")
                    .resizable()
                    .frame(width: layout.image_width, height: layout.image_height)
                Text(totalCoins, format: .number)
                    .foregroundColor(.white)
                    .font(.title3)
            }
        }
    }
}

/// ``ItemBar`` preview for Xcode canvas simulator.
struct TotalCoins_Previews: PreviewProvider {
    static var previews: some View {
        ItemBar(totalCoins: 9999, totalGems: 5)
    }
}
