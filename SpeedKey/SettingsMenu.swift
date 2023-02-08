//
//  SettingsMenu.swift
//  SpeedKey
//
//  Created by Chloe Snyders on 2/6/23.
//

import Foundation
import SwiftUI


struct SettingsMenu: View {
    enum Identifiers: String, CaseIterable, Identifiable {
        case autoDeleteToggle
        case typoNotificationToggle
        case reviewPreviousWordsToggle
        case reviewEntireTextPicker
        case jumpToTypoPicker
        case wordDeletionPicker
        case cursorPicker
        var id: Self { self }
    }
    
    enum Shortcut: String, CaseIterable, Identifiable {
        case sideButton = "Triple-click the side button"
        case swipeAcross = "Swipe across keyboard"
        case doubleTap = "Double tap"
        case swipeUp = "Swipe up"
        case swipeDown = "Swipe down"
        var id: Self { self }
    }
    
    @State private var autoDeleteOn = false
    @State private var typoNotificationOn = false
    @State private var reviewPreivousWordsOn = false
    
    @State private var notificationType = "Vibrate"
    let notificationOptions = ["Vibrate", "Ding"]
    
    @State private var previousWordReviewCount = "5"
    let previousWordCounts = ["5", "10", "15"]
    
    @State private var entireTextReviewShortcut: Shortcut = .sideButton
    @State private var jumpToTypoShortcut: Shortcut = .doubleTap
    @State private var wordDeletionShortcut: Shortcut = .swipeAcross
    @State private var cursorShortcut: Shortcut = .swipeUp
    
    var body: some View {
        VStack {
            Section { // Toggles
                Text("Enable/Disable Toggles:")
                
                // Auto Delete Toggle
                Toggle("Auto-delete on typo", isOn: $autoDeleteOn)
                    .id(SettingsMenu.Identifiers.autoDeleteToggle.rawValue)
                    .accessibilityIdentifier(SettingsMenu.Identifiers.autoDeleteToggle.rawValue)
                
                // Typo Notification Toggle
                Toggle("Enable typo notification", isOn: $typoNotificationOn)
                    .id(SettingsMenu.Identifiers.typoNotificationToggle.rawValue)
                    .accessibilityIdentifier(SettingsMenu.Identifiers.typoNotificationToggle.rawValue)
                
                if typoNotificationOn{
                    Picker("Notification type:", selection: $notificationType) {
                        ForEach(notificationOptions, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                // Review Previous Words Toggle
                Toggle("Review previous 5, 10, or 15 words", isOn: $reviewPreivousWordsOn)
                    .id(SettingsMenu.Identifiers.reviewPreviousWordsToggle.rawValue)
                    .accessibilityIdentifier(SettingsMenu.Identifiers.reviewPreviousWordsToggle.rawValue)
                
                if reviewPreivousWordsOn{
                    Picker("Word count:", selection: $previousWordReviewCount) {
                        ForEach(previousWordCounts, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                }
            }
                 
            Section { // Shortcuts
                Text("Customize Shortcuts:")
                
                List {
                    Picker("Review entire text", selection: $entireTextReviewShortcut) {
                        ForEach(Shortcut.allCases) { shortcut in
                            Text(shortcut.rawValue)
                        }
                        .id(SettingsMenu.Identifiers.reviewEntireTextPicker.rawValue)
                        .accessibilityIdentifier(SettingsMenu.Identifiers.reviewEntireTextPicker.rawValue)
                    }
                    
                    Picker("Jump to typo", selection: $jumpToTypoShortcut) {
                        ForEach(Shortcut.allCases) { shortcut in
                            Text(shortcut.rawValue)
                        }
                        .id(SettingsMenu.Identifiers.jumpToTypoPicker.rawValue)
                        .accessibilityIdentifier(SettingsMenu.Identifiers.jumpToTypoPicker.rawValue)
                    }
                    
                    Picker("Word deletion", selection: $wordDeletionShortcut) {
                        ForEach(Shortcut.allCases) { shortcut in
                            Text(shortcut.rawValue)
                        }
                        .id(SettingsMenu.Identifiers.wordDeletionPicker.rawValue)
                        .accessibilityIdentifier(SettingsMenu.Identifiers.wordDeletionPicker.rawValue)
                    }
                    
                    Picker("Move cursor to end", selection: $cursorShortcut) {
                        ForEach(Shortcut.allCases) { shortcut in
                            Text(shortcut.rawValue)
                        }
                        .id(SettingsMenu.Identifiers.cursorPicker.rawValue)
                        .accessibilityIdentifier(SettingsMenu.Identifiers.cursorPicker.rawValue)
                    }
                }
            }
        }
        .padding()
    }
}
