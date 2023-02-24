// File: LayoutSize.swift
// Project: Persona Pop
// Purpose: A model that contains the sizing for various elememnts in the app
// Created by Reese Barnett on 7/2/22.

import Foundation
import SwiftUI

/// Contains the dynamic sizing for various UI elements.
struct LayoutSize {
    
    /// The width of the screen.
    static let width = UIScreen.main.bounds.width
    
    /// The height of the screen.
    static let height = UIScreen.main.bounds.height
    
    //-------------Fonts---------------
    //MARK: Fonts
    
    /// Font size of credits in ``CreditPopUp``.
    static let creditFontSize: CGFloat = width * 0.07
    
    /// Font size of title in ``HomeView``.
    static let titleFontSize: CGFloat = width * 0.107
    
    /// Size of font in ``SocialPopUp``.
    static let socialFont: (size: CGFloat, spacing: CGFloat) = (width * 0.075, width * 0.025)
    
    /// Size of the text in ``StageIcon`` and ``LockedStage``.
    static let stageCardText: (size1: CGFloat, size2: CGFloat) = (width * 0.1125, width * 0.075)
    
    //-------------Images---------------
    //MARK: Images
    
    /// Size of the coin stack image in ``CorrectAnswerPopUp``.
    static let correctPopUpImage: (width: CGFloat, height: CGFloat) = (width * 0.075, width * 0.075)
    
    /// Size of the coin stack image in ``LockedStage``.
    static let payWallCoinStack: (height: CGFloat, width: CGFloat) = (width * 0.15, width * 0.15)
    
    /// Size of the tutorial  hand animation in ``AnswerField``
    static let touchLottie: (height: CGFloat, width: CGFloat) = (width * 0.5, width * 0.5)
    
    /// Size of icon images in ``AudioPopUp``.
    static let audioImage: (width: CGFloat, height: CGFloat, spacing: CGFloat) = (height * 0.08, height * 0.08, height * 0.03)
    
    /// Size of icon images in ``SocialPopUp``.
    static let socialImage: (width: CGFloat, height: CGFloat) = (height * 0.0625, height * 0.0625 )
    
    /// Size of the artwork in ``Artwork``.
    static let artwork: (radius: CGFloat, width: CGFloat, height: CGFloat) = (height * 0.0625, width * 0.75, width * 0.75)
    
    //-------------Keyboard---------------
    //MARK: Keyboard
    
    /// Size of the keyboard key in ``Key``.
    static let keyboardKey: (radius: CGFloat, width: CGFloat, height: CGFloat) = (height * 0.0125, width * 0.0775, width * 0.1125)
    
    /// Size of the spacebar in ``SpaceBar``.
    static let spaceBar: (radius: CGFloat, width: CGFloat, height: CGFloat) = (height * 0.015, width * 0.5025, width * 0.1025)

    /// Size of the delete key in ``DeleteKey``.
    static let deleteKey: (radius: CGFloat, width: CGFloat, height: CGFloat) = (height * 0.0175, width * 0.1775, width * 0.1025)
    
    /// Size of the input bar in ``InputBar``.
    static let inputBar: (radius: CGFloat, width: CGFloat, height: CGFloat) = (height * 0.0125, width * 0.85, width * 0.1)
    
    //-------------Settings---------------
    //MARK: Settings
    
    /// Size of settings icon in ``SettingsIcon``.
    static let settingsIcon: (width: CGFloat, height: CGFloat) = (width * 0.175, width * 0.175)
    
    /// Size of settings "bubbles" in ``CircleIcon``.
    static let settingsCircle: (icon_width: CGFloat, icon_height: CGFloat, image_width: CGFloat, image_height: CGFloat) = (width * 0.15, width * 0.15, width * 0.097, width * 0.097)
    
    /// Size of settings pop up rectangle in ``AudioPopUp``, ``SocialPopUp``, and ``CreditPopUp``.
    static let settingsPopUp: (radius: CGFloat, width: CGFloat, height: CGFloat) = (height * 0.075, width * 0.75, height * 0.45)
    
    /// Size of play button in ``HomeView``.
    static let playButton: (radius: CGFloat, width: CGFloat, height: CGFloat, textSize: CGFloat, offset: CGFloat) = (height * 0.0375, width * 0.5, height * 0.075, width * 0.1, height *  -0.026)
    
    //-------------Other---------------
    //MARK: Other
    
    /// Size of stage card in ``StageIcon`` and ``LockedStage``.
    /// - Note: `s` and `l` are small and large value for the spring animation.
    static let stageCard: (radius: CGFloat, s_width: CGFloat, s_height: CGFloat, l_width:CGFloat, l_height: CGFloat, offset: CGFloat) = (height * 0.0625, width * 0.675, width * 0.45, width * 0.785, width * 0.585, height * -0.0385)
    
    /// Size of the stage title in ``StageTitle``
    static let stageTitle: (radius: CGFloat, width: CGFloat, height: CGFloat, fontSize: CGFloat) = (height * 0.025, width * 0.8, height * 0.075, width * 0.1)
    
    /// Size of the level icon in ``LevelIcon``.
    static let levelIcon: (radius: CGFloat, width: CGFloat, height: CGFloat) = (height * 0.0275, width * 0.2, width * 0.2)
    
    /// Size of the circle indicators in ``CircleIndicator``
    static let circleIndicator: (width: CGFloat, height: CGFloat) = (width * 0.045, width * 0.045)
    
    /// Size of the total coins icon in ``TotalCoins``.
    static let totalCoins: (radius: CGFloat, width: CGFloat, height: CGFloat, image_height: CGFloat, image_width: CGFloat) = (height * 0.02, width * 0.455, height * 0.06375, width * 0.08, width * 0.08)
    
    /// Size of the correct answer pop up in ``CorrectAnswerPopUp``.
    static let correctPopUp: (radius: CGFloat, width: CGFloat, height: CGFloat) = (height * 0.06375, width * 0.8725, height * 0.29)
    
    /// Size of the buttons in ``CorrectAnswerPopUp``.
    static let correctPopUpButton: (radius: CGFloat, width: CGFloat, height: CGFloat) = (height * 0.025, width * 0.26, height * 0.0675)
}
