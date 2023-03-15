//
//  SettingsMenu.swift
//  SpeedKey
//
//  Created by Chloe Snyders on 2/6/23.
//

import Foundation
import SwiftUI

// TODO: when SpeedKey is enabled, need to check that keyboard has full access -- if full access is not granted (hasFullAccess), then need to display a popup/alert to tell user to turn on "Allow Full Access" in iPhone settings menu, see https://developer.apple.com/documentation/swiftui/view/alert(_:ispresented:presenting:actions:message:)-8584l for how to create an alert
    //Note: https://shyngys.com/ios-custom-keyboard-guide shows how to open keyboard settings menu


public class Settings: ObservableObject {
    
    enum Shortcut: String, CaseIterable, Identifiable {
        case sideButton = "Triple-click the side button"
        case swipeAcross = "Swipe across keyboard"
        case doubleTap = "Double tap"
        case swipeUp = "Swipe up"
        case swipeDown = "Swipe down"
        var id: Self { self }
    }
    
    @Published var speedKeyOn = false
    @Published var autoDeleteOn = false
    @Published var typoNotificationOn = false
    @Published var reviewPreivousWordsOn = false
    
    @Published var notificationType = "Vibrate"
    @Published var previousWordReviewCount = "5"
    
    @Published var entireTextReviewShortcut: Shortcut = .sideButton
    @Published var jumpToTypoShortcut: Shortcut = .doubleTap
    @Published var wordDeletionShortcut: Shortcut = .swipeAcross
    @Published var cursorShortcut: Shortcut = .swipeUp
    
    public init() {}
    
    public func getWordReviewCount() -> String {
        return previousWordReviewCount
    }
}


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
    
    let notificationOptions = ["Vibrate", "Ding"]
    
    let previousWordCounts = ["5", "10", "15"]
    
    @ObservedObject var settings: Settings = Settings()
    
    var body: some View {
        
        VStack {
            Section { // Enable SpeedKey
                Toggle("Enable SpeedKey", isOn: $settings.speedKeyOn)
                    .id(Identifiers.speedKeyToggle.rawValue)
                    .accessibilityIdentifier(Identifiers.speedKeyToggle.rawValue)
                    .accessibilityHint(settings.speedKeyOn ? Hints.disableSpeedKey.rawValue : Hints.enableSpeedKey.rawValue)
            } // Section
            .padding([.bottom], 20)
                
            Section { // Toggles
                
                // Auto Delete Toggle
                Toggle("Enable auto-delete on typo", isOn: $settings.autoDeleteOn)
                    .id(Identifiers.autoDeleteToggle.rawValue)
                    .accessibilityIdentifier(Identifiers.autoDeleteToggle.rawValue)
                    .accessibilityHint(settings.autoDeleteOn ? Hints.disableAutoDelete.rawValue : Hints.enableAutoDelete.rawValue)
                
                // Typo Notification Toggle
                Toggle("Enable typo notification", isOn: $settings.typoNotificationOn)
                    .id(Identifiers.typoNotificationToggle.rawValue)
                    .accessibilityIdentifier(Identifiers.typoNotificationToggle.rawValue)
                    .accessibilityHint(settings.typoNotificationOn ? Hints.disableTypoNotification.rawValue : Hints.enableTypoNotification.rawValue)
                
                if settings.typoNotificationOn{
                    Picker("Select notification type", selection: $settings.notificationType) {
                        ForEach(notificationOptions, id: \.self) {
                            Text($0)
                                .accessibilityLabel("\($0) on typo")
                        }
                    }
                    .pickerStyle(.menu)
                    .accessibilityHint(Hints.selectTypoNotification.rawValue)
                }
                
                // Review Previous Words Toggle
                Toggle("Enable review of previous 5, 10, or 15 words", isOn: $settings.reviewPreivousWordsOn)
                    .id(Identifiers.reviewPreviousWordsToggle.rawValue)
                    .accessibilityIdentifier(Identifiers.reviewPreviousWordsToggle.rawValue)
                    .accessibilityHint(settings.reviewPreivousWordsOn ? Hints.disableWordReview.rawValue : Hints.enableWordReview.rawValue)
                
                if settings.reviewPreivousWordsOn{
                    Picker("Word count:", selection: $settings.previousWordReviewCount) {
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
                    Picker("Review entire text", selection: $settings.entireTextReviewShortcut) {
                        ForEach(Settings.Shortcut.allCases) { shortcut in
                            Text(shortcut.rawValue)
                                .accessibilityLabel(shortcut.rawValue)
                        }
                        .id(Identifiers.reviewEntireTextPicker.rawValue)
                        .accessibilityIdentifier(Identifiers.reviewEntireTextPicker.rawValue)
                        .accessibilityHint(Hints.selectShortcutReviewText.rawValue)
                    }
                    
                    Picker("Jump to typo", selection: $settings.jumpToTypoShortcut) {
                        ForEach(Settings.Shortcut.allCases) { shortcut in
                            Text(shortcut.rawValue)
                                .accessibilityLabel(shortcut.rawValue)
                        }
                        .id(Identifiers.jumpToTypoPicker.rawValue)
                        .accessibilityIdentifier(Identifiers.jumpToTypoPicker.rawValue)
                        .accessibilityHint(Hints.selectShortcutJumpTypo.rawValue)
                    }
                    
                    Picker("Word deletion", selection: $settings.wordDeletionShortcut) {
                        ForEach(Settings.Shortcut.allCases) { shortcut in
                            Text(shortcut.rawValue)
                                .accessibilityLabel(shortcut.rawValue)
                        }
                        .id(Identifiers.wordDeletionPicker.rawValue)
                        .accessibilityIdentifier(Identifiers.wordDeletionPicker.rawValue)
                        .accessibilityHint(Hints.selectShortcutWordDeletion.rawValue)
                    }
                    
                    Picker("Move cursor to end", selection: $settings.cursorShortcut) {
                        ForEach(Settings.Shortcut.allCases) { shortcut in
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
