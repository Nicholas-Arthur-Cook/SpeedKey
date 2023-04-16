//
//  AccessDefaults.swift
//  SpeedKey Keyboard
//
//  Created by Chloe Snyders on 3/20/23.
//

import Foundation

class AccessDefaults {
    private func getSetting(key: String) -> Any? {
        let defaults = UserDefaults(suiteName: "group.eecs495.SpeedKey")
        return defaults?.object(forKey: key)
    }
    
    private let defaultShortcut = "-"
    
    public func getAutoDeleteOn() -> Bool {return getSetting(key: "autoDeleteOn") as? Bool ?? false}
    
    public func getTypoNotificationOn() -> Bool {return getSetting(key: "typoNotificationOn") as? Bool ?? false}
    
    public func getReviewPreivousWordsOn() -> Bool {return getSetting(key: "reviewPreivousWordsOn") as? Bool ?? false}
    
    
    public func getNotificationType() -> String {
        return getSetting(key: "notificationType") as? String ?? "Vibrate"
    }
    
    public func getPreviousWordReviewMode() -> String {
        return getSetting(key: "previousWordReviewMode") as? String ?? "Words"
    }
    
    public func getEntireTextReviewShortcut() -> String {
        return getSetting(key: "entireTextReviewShortcut") as? String ?? "Swipe up"
    }
    
    public func getJumpToTypoShortcut() -> String {
        return getSetting(key: "jumpToTypoShortcut") as? String ?? "Swipe down"
    }
    
    public func getWordDeletionShortcut() -> String {
        return getSetting(key: "wordDeletionShortcut") as? String ?? "Swipe left"
    }
    
    public func getCursorShortcut() -> String {
        return getSetting(key: "cursorShortcut") as? String ?? "Swipe right"
    }
    
    public func getFreqTypos() -> [String] {
        return getSetting(key: "freqTypos") as? [String] ?? [""]
    }
}
