//
//  SettingsMenu.swift
//  SpeedKey
//
//  Created by Chloe Snyders on 2/6/23.
//

import Foundation
import SwiftUI

let userDefaults = UserDefaults(suiteName: "group.eecs495.SpeedKey")
let notificationOptions = ["Vibrate", "Ding"]
let previousWordCounts = ["5", "10", "15"]
let shortcuts = ["Swipe up", "Swipe down", "Swipe right", "Swipe left", "-"]
let typingModes = ["Announce Words", "Announce Characters"]


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
        case typingModePicker
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
        case selectTypingMode = "Select a typing mode"
        var id: Self { self }
    }
    
    @AppStorage("speedKeyOn", store: userDefaults) var speedKeyOn = false
    @AppStorage("autoDeleteOn", store: userDefaults) var autoDeleteOn = false
    @AppStorage("typoNotificationOn", store: userDefaults) var typoNotificationOn = false
    @AppStorage("reviewPreivousWordsOn", store: userDefaults) var reviewPreivousWordsOn = false
    
    @AppStorage("notificationType", store: userDefaults) var notificationType = notificationOptions[0]
    @AppStorage("previousWordReviewCount", store: userDefaults) var previousWordReviewCount = previousWordCounts[0]
    
    @AppStorage("entireTextReviewShortcut", store: userDefaults) var entireTextReviewShortcut = shortcuts[0]
    @AppStorage("jumpToTypoShortcut", store: userDefaults) var jumpToTypoShortcut = shortcuts[1]
    @AppStorage("wordDeletionShortcut", store: userDefaults) var wordDeletionShortcut = shortcuts[2]
    @AppStorage("cursorShortcut", store: userDefaults) var cursorShortcut = shortcuts[3]
    
    @AppStorage("typingMode", store: userDefaults) var typingMode = typingModes[0]
    
    
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
                VStack {
                    Picker("Select Typing Mode", selection: $typingMode) {
                        ForEach(typingModes, id: \.self) {
                            Text($0)
                                .accessibilityLabel("\($0)")
                        }
                    }
                    .id(Identifiers.typingModePicker.rawValue)
                    .accessibilityIdentifier(Identifiers.typingModePicker.rawValue)
                    .accessibilityHint(Hints.selectTypingMode.rawValue)
                }
                .pickerStyle(.segmented)
                
            } // Section
            
            Section { // Shortcuts
                Text("Customize Shortcuts:")
                
                List {
                    Picker("Review entire text", selection: $entireTextReviewShortcut) {
                        ForEach(shortcuts, id: \.self) {
                            Text($0)
                                .accessibilityLabel("\($0)")
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
                        .id(Identifiers.jumpToTypoPicker.rawValue)
                        .accessibilityIdentifier(Identifiers.jumpToTypoPicker.rawValue)
                        .accessibilityHint(Hints.selectShortcutJumpTypo.rawValue)
                    }
                    
                    Picker("Word deletion", selection: $wordDeletionShortcut) {
                        ForEach(shortcuts, id: \.self) {
                            Text($0)
                                .accessibilityLabel("\($0)")
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
