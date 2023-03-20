//
//  AccessDefaults.swift
//  SpeedKey Keyboard
//
//  Created by Chloe Snyders on 3/20/23.
//

import Foundation

class AccessDefaults {
    private let defaults = UserDefaults(suiteName: "group.eecs495.SpeedKey")
    
    private func getSetting(key: String) -> Any? {
        let defaults = UserDefaults(suiteName: "group.eecs495.SpeedKey")
        return defaults?.object(forKey: key)
    }
    
    public func getSpeedKeyOn() -> Bool { return getSetting(key: "speedKeyOn") as! Bool }
    
    public func getAutoDeleteOn() -> Bool { return getSetting(key: "autoDeleteOn") as! Bool }
    
    public func getTypoNotificationOn() -> Bool { return getSetting(key: "typoNotificationOn") as! Bool }
    
    public func getReviewPreivousWordsOn() -> Bool { return getSetting(key: "reviewPreivousWordsOn") as! Bool }
    
    public func getNotificationType() -> String { return getSetting(key: "notificationType") as! String }
    
    public func getPreviousWordReviewCount() -> String { return getSetting(key: "previousWordReviewCount") as! String }
    
    public func getEntireTextReviewShortcut() -> String { return getSetting(key: "entireTextReviewShortcut") as! String }
    
    public func getJumpToTypoShortcut() -> String { return getSetting(key: "jumpToTypoShortcut") as! String }
    
    public func getWordDeletionShortcut() -> String { return getSetting(key: "wordDeletionShortcut") as! String }
    
    public func getCursorShortcut() -> String { return getSetting(key: "cursorShortcut") as! String }
}
