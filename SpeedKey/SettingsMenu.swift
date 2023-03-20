//
//  SettingsMenu.swift
//  SpeedKey
//
//  Created by Chloe Snyders on 2/6/23.
//

import Foundation
import SwiftUI


let defaults: Defaults = Defaults()

let notificationOptions = ["Vibrate", "Ding"]
let previousWordCounts = ["5", "10", "15"]
let shortcuts = ["Swipe up", "Swipe down", "Swipe right", "Swipe left"]


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
    
    @State private var notificationType = notificationOptions[0]
    @State var previousWordReviewCount = previousWordCounts[0]
    
    @State private var entireTextReviewShortcut = shortcuts[0]
    @State private var jumpToTypoShortcut = shortcuts[1]
    @State private var wordDeletionShortcut = shortcuts[2]
    @State private var cursorShortcut = shortcuts[3]
    
    var body: some View {
        
        VStack {
            Section { // Enable SpeedKey
                Toggle("Enable SpeedKey", isOn: $speedKeyOn)
                    .onChange(of: speedKeyOn) { value in
                        defaults.update(value: value, key: "speedKeyOn")
                    }
                    .id(Identifiers.speedKeyToggle.rawValue)
                    .accessibilityIdentifier(Identifiers.speedKeyToggle.rawValue)
                    .accessibilityHint(speedKeyOn ? Hints.disableSpeedKey.rawValue : Hints.enableSpeedKey.rawValue)
            } // Section
            .padding([.bottom], 20)
                
            Section { // Toggles
                
                // Auto Delete Toggle
                Toggle("Enable auto-delete on typo", isOn: $autoDeleteOn)
                    .onChange(of: autoDeleteOn) { value in
                        defaults.update(value: autoDeleteOn, key: "autoDeleteOn")
                    }
                    .id(Identifiers.autoDeleteToggle.rawValue)
                    .accessibilityIdentifier(Identifiers.autoDeleteToggle.rawValue)
                    .accessibilityHint(autoDeleteOn ? Hints.disableAutoDelete.rawValue : Hints.enableAutoDelete.rawValue)
                
                // Typo Notification Toggle
                Toggle("Enable typo notification", isOn: $typoNotificationOn)
                    .onChange(of: typoNotificationOn) { value in
                        defaults.update(value: typoNotificationOn, key: "typoNotificationOn")
                    }
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
                    .onChange(of: notificationType) { value in
                        defaults.update(value: notificationType, key: "notificationType")
                    }
                    .pickerStyle(.menu)
                    .accessibilityHint(Hints.selectTypoNotification.rawValue)
                }
                
                // Review Previous Words Toggle
                Toggle("Enable review of previous 5, 10, or 15 words", isOn: $reviewPreivousWordsOn)
                    .onChange(of: reviewPreivousWordsOn) { value in
                        defaults.update(value: reviewPreivousWordsOn, key: "reviewPreivousWordsOn")
                    }
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
                    .onChange(of: previousWordReviewCount) { value in
                        defaults.update(value: previousWordReviewCount, key: "previousWordReviewCount")
                    }
                    .pickerStyle(.menu)
                    .accessibilityHint(Hints.selectReviewWordCount.rawValue)
                }
            } // Section
            
            Section { // Shortcuts
                Text("Customize Shortcuts:")
                
                List {
                    Picker("Review entire text", selection: $entireTextReviewShortcut) {
                        ForEach(shortcuts, id: \.self) {
                            Text($0)
                                .accessibilityLabel("\($0)")
                        }
                        .onChange(of: entireTextReviewShortcut) { value in
                            defaults.update(value: entireTextReviewShortcut, key: "entireTextReviewShortcut")
                        }
                        .id(Identifiers.reviewEntireTextPicker.rawValue)
                        .accessibilityIdentifier(Identifiers.reviewEntireTextPicker.rawValue)
                        .accessibilityHint(Hints.selectShortcutReviewText.rawValue)
                    }
                    
                    Picker("Jump to typo", selection: $jumpToTypoShortcut) {
                        ForEach(shortcuts, id: \.self) {
                            Text($0)
                                .accessibilityLabel("\($0)")
                        }
                        .onChange(of: jumpToTypoShortcut) { value in
                            defaults.update(value: jumpToTypoShortcut, key: "jumpToTypoShortcut")
                        }
                        .id(Identifiers.jumpToTypoPicker.rawValue)
                        .accessibilityIdentifier(Identifiers.jumpToTypoPicker.rawValue)
                        .accessibilityHint(Hints.selectShortcutJumpTypo.rawValue)
                    }
                    
                    Picker("Word deletion", selection: $wordDeletionShortcut) {
                        ForEach(shortcuts, id: \.self) {
                            Text($0)
                                .accessibilityLabel("\($0)")
                        }
                        .onChange(of: wordDeletionShortcut) { value in
                            defaults.update(value: wordDeletionShortcut, key: "wordDeletionShortcut")
                        }
                        .id(Identifiers.wordDeletionPicker.rawValue)
                        .accessibilityIdentifier(Identifiers.wordDeletionPicker.rawValue)
                        .accessibilityHint(Hints.selectShortcutWordDeletion.rawValue)
                    }
                    
                    Picker("Move cursor to end", selection: $cursorShortcut) {
                        ForEach(shortcuts, id: \.self) {
                            Text($0)
                                .accessibilityLabel("\($0)")
                        }
                        .onChange(of: cursorShortcut) { value in
                            defaults.update(value: cursorShortcut, key: "cursorShortcut")
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
