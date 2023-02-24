// File: NotificationModel.swift
// Project: Persona Pop
// Purpose: Manage notification
// Created by Reese Barnett on 1/6/23.

import Foundation
import UserNotifications
import UIKit

/// Manages local notifications.
struct NotificationModel {
    
    /// Manages notification request and updates.
    static private let center = UNUserNotificationCenter.current()
    
    /// A unique id for the notification.
    static private let identifier = UUID().uuidString
    
    /// The content in the notification.
    static private var content: UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = "Persona Pop"
        content.body = "Only 1% Can Beat All The Levels🥇"
        content.sound = UNNotificationSound.default
        content.badge = 1
        return content
    }
    
    /// The time of day the notification will be delivered.
    static private var date: DateComponents {
        var date = DateComponents()
        date.calendar = Locale.current.calendar
        date.timeZone = TimeZone.current
        date.hour = 18
        date.minute = 00
        return date
    }
    
    /// Gets the user's permission/schedules notifications when needed.
    static func check() async {
        
        var status = await center.notificationSettings().authorizationStatus
        
        // Request notification authorization
        if status == .notDetermined {
            do {
                try await center.requestAuthorization(options: [.badge, .sound, .alert])
            } catch {return}
            
            //Status will changed based on authorization results
            status = await center.notificationSettings().authorizationStatus
        }
        
        guard status == .authorized || status == .ephemeral else {
            center.removeAllPendingNotificationRequests()
            return
        }
        
        await scheduleNotification()
    }
    
    /// Schedules the notification based on `content` and `date`.
    private static func scheduleNotification() async {
        
        let pendingRequest = await center.pendingNotificationRequests()
        
        // Only schedule when there are no request
        guard pendingRequest.isEmpty else {return}
        
        //TODO: Schedule notification properly
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        do {
            try await center.add(request)
        } catch {
            print("Error scheduling notification: \(error)")
        }
    }
    
    /// Removes app icon badge.
    @MainActor
    static func removeBadge() {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
}
