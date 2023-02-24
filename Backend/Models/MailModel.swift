// File: MailModel.swift
// Project: Persona Pop
// Purpose: Object containing info about a mail view
// Created by Reese Barnett on 6/6/22.


import Foundation

/// Contains data for creating an email to the dev team.
struct MailModel {
    
    /// The subject of the email.
    static let subject = "Persona Pop Suppourt"
    
    /// The emails to send to.
    static let recipients = [SocialLink.email]
    
    /// The email header.
    static let message = "Dev Team,\n"
}
