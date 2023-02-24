// File: KeyBoard.swift
// Project: Persona Pop
// Purpose: Display a keyboard that edits the passed in string
// Created by Reese Barnett on 2/5/22.

import SwiftUI

/// A view that displays the keyboard.
struct KeyBoard: View {
    
    private let columns = Array(repeating: GridItem(.fixed(15)), count: 10)
    private let letters = ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P","A", "S", "D", "F", "G", "H","J", "K", "L", "Z", "X", "C","V", "B", "N", "M"]
    
    @State private var wrongAnswer = false
    @Binding var levelCompleted: Bool
    let hideKeyboard: Bool
    
    var body: some View {
        VStack {
            
            InputBar(showXSign: $wrongAnswer)
                .padding(.bottom)
            
            if(!hideKeyboard) {
                ForEach(0...2, id: \.self) { i in
                    HStack {
                        ForEach(startValue(i)...endValue(i), id: \.self) { l in
                            Key(letter: letters[l], showXSign: $wrongAnswer)
                        }
                    }
                }
                
                HStack {
                    DeleteKey(showXSign: $wrongAnswer)
                    SpaceBar(showXSign: $wrongAnswer)
                    CheckKey(levelCompleted: $levelCompleted, showXSign: $wrongAnswer)
                }
            }
        }
    }
    
    /// Gets the `ForEach`'s range starting value for the ith row in the keyboard.
    /// - Parameter i: the keyboard row number (starting at 0).
    /// - Returns: The starting value of the range.
    private func startValue(_ i: Int) -> Int {
        (10 * i) + (i * (1 - i) + Int(i/2))
    }
    
    /// Gets the `ForEach`'s range ending value for the ith row in the keyboard.
    /// - Parameter i: the keyboard row number (starting at 0).
    /// - Returns: The ending value of the range.
    private func endValue(_ i: Int) -> Int {
        (9 * (i+1)) - (i * (i-1))
    }
}

/// ``KeyBoard`` preview for Xcode canvas simulator.
struct KeyBoard_Previews: PreviewProvider {
    static var previews: some View {
        KeyBoard(levelCompleted: .constant(false), hideKeyboard: false)
            .environmentObject(AudioController())
            .environmentObject(GameController())
    }
}


/// A view that displays a keyboard key.
struct Key: View {
    
    let letter: String
    private let key = LayoutSize.keyboardKey
    
    @Binding var showXSign: Bool
    @EnvironmentObject var audioModel: AudioController
    @EnvironmentObject var gameModel: GameController
    
    var body: some View {
        
        Button {
            audioModel.play(sound: .keyboard)
            gameModel.updateInput(operation: .addLetter, letter)
            showXSign = false
        } label: {
            ZStack {
                ElementStyle(radius: key.radius, width: key.width, height: key.height)
                Text(letter)
                    .foregroundColor(.white)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}


/// A view that displays the space bar.
struct SpaceBar: View {
    
    private let spaceBar = LayoutSize.spaceBar
    
    @Binding var showXSign: Bool
    @EnvironmentObject var audioModel: AudioController
    @EnvironmentObject var gameModel: GameController
    
    var body: some View {
        Button {
            audioModel.play(sound: .keyboard)
            gameModel.updateInput(operation: .space)
            showXSign = false
        } label: {
            ZStack {
                ElementStyle(radius: spaceBar.radius, width: spaceBar.width, height: spaceBar.height)
                Text("SPACE")
                    .foregroundColor(.white)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}


/// A view that displays the delete key.
struct DeleteKey: View {
    
    private let key = LayoutSize.deleteKey
    
    @Binding var showXSign: Bool
    @EnvironmentObject var audioModel: AudioController
    @EnvironmentObject var gameModel: GameController
    
    var body: some View {
        Button {
            audioModel.play(sound: .keyboard)
            gameModel.updateInput(operation: .delete)
            showXSign = false
        } label: {
            ZStack {
                ElementStyle(radius: key.radius, width: key.width, height: key.height)
                Text("DEL")
                    .foregroundColor(.white)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}


/// A view that displays the user's input.
struct InputBar: View {
    
    private let bar = LayoutSize.inputBar
    @Binding var showXSign:Bool
    @EnvironmentObject var gameModel: GameController
    
    var body: some View {
        ZStack {
            
            ElementStyle(radius: bar.radius, width: bar.width, height: bar.height, color: "Accent", outlineColor: showXSign ? .red : .white)
            
            Text(gameModel.level.isCorrect ? gameModel.level.answer : gameModel.input)
                .font(.system(size: 25))
                .minimumScaleFactor(0.5)
                .foregroundColor(.white)
                .lineLimit(1)
                .frame(width: bar.width - 16)
        }
    }
}

/// A view that displays the "check answer" button.
struct CheckKey: View {
    
    private let key = LayoutSize.deleteKey
    
    @Binding var levelCompleted: Bool
    @Binding var showXSign: Bool
    @EnvironmentObject var gameModel: GameController
    
    var body: some View {
        
        Button {
            levelCompleted = gameModel.checkAnswer()
            showXSign = !levelCompleted
            
        } label: {
            ZStack {
                
                ElementStyle(radius: key.radius, width: key.width, height: key.height)
                
                Image(systemName: "checkmark")
                    .foregroundColor(.white)
            }
        }
    }
}
