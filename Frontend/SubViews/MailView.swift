// File: MailView.swift
// Project: Persona Pop
// Purpose:
// Created by Reese Barnett on 6/6/22.
// Source: https://swiftuirecipes.com/blog/send-mail-in-swiftui

import Foundation
import SwiftUI
import UIKit
import MessageUI

typealias MailViewCallback = ((Result<MFMailComposeResult, Error>) -> Void)?

/// A view that displays a native way to email the dev team.
struct MailView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentation
    let callback: MailViewCallback
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        
        @Binding var presentation: PresentationMode
        let callback: MailViewCallback
        
        init(presentation: Binding<PresentationMode>, callback: MailViewCallback) {
            _presentation = presentation
            self.callback = callback
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
            if let error = error {
                callback?(.failure(error))
            } else {
                callback?(.success(result))
            }
        
            $presentation.wrappedValue.dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(presentation: presentation, callback: callback)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = context.coordinator
        vc.setSubject(MailModel.subject)
        vc.setToRecipients(MailModel.recipients)
        vc.setMessageBody(MailModel.message, isHTML: false)
        vc.accessibilityElementDidLoseFocus()
        return vc
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: UIViewControllerRepresentableContext<MailView>) {}

    static var canSendMail: Bool {
        MFMailComposeViewController.canSendMail()
    }
}
