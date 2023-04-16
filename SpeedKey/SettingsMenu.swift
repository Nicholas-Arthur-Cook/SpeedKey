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
let shortcuts = ["Swipe up", "Swipe down", "Swipe right", "Swipe left", "-"]
let reviewCounts = ["Characters", "Words", "5 Words", "10 Words", "15 Words", "Sentences"]


struct SettingsMenu: View {
    enum Identifiers: String, CaseIterable, Identifiable {
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
    
    @AppStorage("autoDeleteOn", store: userDefaults) var autoDeleteOn = false
    @AppStorage("typoNotificationOn", store: userDefaults) var typoNotificationOn = false
    @AppStorage("reviewPreivousWordsOn", store: userDefaults) var reviewPreivousWordsOn = false
    
    @AppStorage("notificationType", store: userDefaults) var notificationType = notificationOptions[0]
    @AppStorage("previousWordReviewMode", store: userDefaults) var previousWordReviewMode = reviewCounts[1]
    
    @AppStorage("entireTextReviewShortcut", store: userDefaults) var entireTextReviewShortcut = shortcuts[0]
    @AppStorage("jumpToTypoShortcut", store: userDefaults) var jumpToTypoShortcut = shortcuts[1]
    @AppStorage("wordDeletionShortcut", store: userDefaults) var wordDeletionShortcut = shortcuts[2]
    @AppStorage("cursorShortcut", store: userDefaults) var cursorShortcut = shortcuts[3]
    
    /**
            Ensure there are no duplicate gestures selected in the Customize Shortcuts section.
     */
    func validGestures(gestureToCheck: inout String, forShortcut: String) {
        if gestureToCheck == entireTextReviewShortcut && forShortcut != "review" {
            entireTextReviewShortcut = shortcuts[4]
        }
        if gestureToCheck == jumpToTypoShortcut && forShortcut != "typo" {
            jumpToTypoShortcut = shortcuts[4]
        }
        if gestureToCheck == wordDeletionShortcut && forShortcut != "delete" {
            wordDeletionShortcut = shortcuts[4]
        }
        if gestureToCheck == cursorShortcut && forShortcut != "cursor" {
            cursorShortcut = shortcuts[4]
        }
    }
    
    var body: some View {
        Form {
            Section(header: Text("Typo Settings")) {
                
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
                    Picker("Notification type", selection: $notificationType) {
                        ForEach(notificationOptions, id: \.self) {
                            Text($0)
                                .accessibilityLabel("\($0) on typo")
                        }
                    }
                    .accessibilityHint(Hints.selectTypoNotification.rawValue)
                }
                
                NavigationLink(destination: FrequentTypos()) {
                    Text("Specify Frequently Used Typos")
                }
                
            } // Section
            
            Section(header: Text("Text Review Settings")) {
                // Review Previous Words Toggle
                Toggle("Enable automatic review of typed text", isOn: $reviewPreivousWordsOn)
                    .id(Identifiers.reviewPreviousWordsToggle.rawValue)
                    .accessibilityIdentifier(Identifiers.reviewPreviousWordsToggle.rawValue)
                    .accessibilityHint(reviewPreivousWordsOn ? Hints.disableWordReview.rawValue : Hints.enableWordReview.rawValue)
                
                if reviewPreivousWordsOn{
                    Picker("Mode", selection: $previousWordReviewMode) {
                        ForEach(reviewCounts, id: \.self) {
                            Text($0)
                                .accessibilityLabel("\($0)")
                        }
                    }
                    .accessibilityHint(Hints.selectReviewWordCount.rawValue)
                }
                
            } // Section
            
            Section(header:
                        VStack(alignment: .leading) {
                            Text("Shortcuts")
                            Text("select each gesture at most once")
                                .font(.caption)
                                .textCase(.lowercase)
                        }
            ) {
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
                    .onChange(of: entireTextReviewShortcut) { _ in
                        validGestures(gestureToCheck: &entireTextReviewShortcut, forShortcut: "review")
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
                    .onChange(of: jumpToTypoShortcut) { _ in
                        validGestures(gestureToCheck: &jumpToTypoShortcut, forShortcut: "typo")
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
                    .onChange(of: wordDeletionShortcut) { _ in
                        validGestures(gestureToCheck: &wordDeletionShortcut, forShortcut: "delete")
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
                    .onChange(of: cursorShortcut) { _ in
                        validGestures(gestureToCheck: &cursorShortcut, forShortcut: "cursor")
                    }
                } // List
                
            } // Section
            
        } // Form
        .padding()
    }
}
