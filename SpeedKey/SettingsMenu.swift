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
        case speedKeyToggle
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
    
    enum Hints: String, CaseIterable, Identifiable {
        case enableSpeedKey = "Double tap to enable SpeedKey"
        case disableSpeedKey = "Double tap to disable SpeedKey"
        case enableAutoDelete = "Double tap to enable auto-delete on typo"
        case disableAutoDelete = "Double tap to disable auto-delete on typo"
        case enableTypoNotification = "Double tap to dnable typo notification"
        case disableTypoNotification = "Double tap to disable typo notification"
        case selectTypoNotification = "Select typo notification"
        case enableWordReview = "Double tap to enable review of 5, 10, or 15 words"
        case disableWordReview = "Double tap to disable review of 5, 10, or 15 words"
        case selectReviewWordCount = "Select review word count"
        case selectShortcutReviewText = "Select shortcut to review entire text"
        case selectShortcutJumpTypo = "Select shortcut to jump to typo"
        case selectShortcutWordDeletion = "Select shortcut to delete word"
        case selectShortcutMoveCursor = "Select shortcut to move cursor to end"
        var id: Self { self }
    }
    
    @State private var speedKeyOn = false
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
            Section { // Enable SpeedKey
                Toggle("Enable SpeedKey", isOn: $speedKeyOn)
                    .id(Identifiers.speedKeyToggle.rawValue)
                    .accessibilityIdentifier(Identifiers.speedKeyToggle.rawValue)
                    .accessibilityHint(speedKeyOn ? Hints.disableSpeedKey.rawValue : Hints.enableSpeedKey.rawValue)
            } // Section
            .padding([.bottom], 20)
                
            Section { // Toggles
                
                // Auto Delete Toggle
                Toggle("Enable auto-delete on typo", isOn: $autoDeleteOn)
                    .id(Identifiers.autoDeleteToggle.rawValue)
                    .accessibilityIdentifier(Identifiers.autoDeleteToggle.rawValue)
                    .accessibilityHint(autoDeleteOn ? Hints.disableAutoDelete.rawValue : Hints.enableAutoDelete.rawValue)
                
                // Typo Notification Toggle
                Toggle("Enable typo notification", isOn: $typoNotificationOn)
                    .id(Identifiers.typoNotificationToggle.rawValue)
                    .accessibilityIdentifier(Identifiers.typoNotificationToggle.rawValue)
                    .accessibilityHint(typoNotificationOn ? Hints.disableTypoNotification.rawValue : Hints.enableTypoNotification.rawValue)
                
                if typoNotificationOn{
                    Picker("Select notification type", selection: $notificationType) {
                        ForEach(notificationOptions, id: \.self) {
                            Text($0)
                                .accessibilityLabel("\($0) on typo")
                        }
                    }
                    .pickerStyle(.menu)
                    .accessibilityHint(Hints.selectTypoNotification.rawValue)
                }
                
                // Review Previous Words Toggle
                Toggle("Enable review of previous 5, 10, or 15 words", isOn: $reviewPreivousWordsOn)
                    .id(Identifiers.reviewPreviousWordsToggle.rawValue)
                    .accessibilityIdentifier(Identifiers.reviewPreviousWordsToggle.rawValue)
                    .accessibilityHint(reviewPreivousWordsOn ? Hints.disableWordReview.rawValue : Hints.enableWordReview.rawValue)
                
                if reviewPreivousWordsOn{
                    Picker("Word count:", selection: $previousWordReviewCount) {
                        ForEach(previousWordCounts, id: \.self) {
                            Text($0)
                                .accessibilityLabel("\($0) words")
                        }
                    }
                    .pickerStyle(.menu)
                    .accessibilityHint(Hints.selectReviewWordCount.rawValue)
                }
            } // Section
            
            Section { // Shortcuts
                Text("Customize Shortcuts:")
                
                List {
                    Picker("Review entire text", selection: $entireTextReviewShortcut) {
                        ForEach(Shortcut.allCases) { shortcut in
                            Text(shortcut.rawValue)
                                .accessibilityLabel(shortcut.rawValue)
                        }
                        .id(Identifiers.reviewEntireTextPicker.rawValue)
                        .accessibilityIdentifier(Identifiers.reviewEntireTextPicker.rawValue)
                        .accessibilityHint(Hints.selectShortcutReviewText.rawValue)
                    }
                    
                    Picker("Jump to typo", selection: $jumpToTypoShortcut) {
                        ForEach(Shortcut.allCases) { shortcut in
                            Text(shortcut.rawValue)
                                .accessibilityLabel(shortcut.rawValue)
                        }
                        .id(Identifiers.jumpToTypoPicker.rawValue)
                        .accessibilityIdentifier(Identifiers.jumpToTypoPicker.rawValue)
                        .accessibilityHint(Hints.selectShortcutJumpTypo.rawValue)
                    }
                    
                    Picker("Word deletion", selection: $wordDeletionShortcut) {
                        ForEach(Shortcut.allCases) { shortcut in
                            Text(shortcut.rawValue)
                                .accessibilityLabel(shortcut.rawValue)
                        }
                        .id(Identifiers.wordDeletionPicker.rawValue)
                        .accessibilityIdentifier(Identifiers.wordDeletionPicker.rawValue)
                        .accessibilityHint(Hints.selectShortcutWordDeletion.rawValue)
                    }
                    
                    Picker("Move cursor to end", selection: $cursorShortcut) {
                        ForEach(Shortcut.allCases) { shortcut in
                            Text(shortcut.rawValue)
                                .accessibilityLabel(shortcut.rawValue)
                        }
                        .id(Identifiers.cursorPicker.rawValue)
                        .accessibilityIdentifier(Identifiers.cursorPicker.rawValue)
                        .accessibilityHint(Hints.selectShortcutMoveCursor.rawValue)
                    }
                } // List
                
            } // Section
            
        } // VStack
        .padding()
    }
}
