//
//  Defaults.swift
//  SpeedKey
//
//  Created by Chloe Snyders on 3/19/23.
//

import Foundation


class Defaults {
    let defaults = UserDefaults(suiteName: "group.eecs495.SpeedKey")
    
    public init() {
        defaults!.set(false, forKey: "speedKeyOn")
        defaults!.set(false, forKey: "autoDeleteOn")
        defaults!.set(false, forKey: "typoNotificationOn")
        defaults!.set(false, forKey: "reviewPreivousWordsOn")
        defaults!.set(notificationOptions[0], forKey: "notificationType")
        defaults!.set(previousWordCounts[0], forKey: "previousWordReviewCount")
        defaults!.set(shortcuts[0], forKey: "entireTextReviewShortcut")
        defaults!.set(shortcuts[1], forKey: "jumpToTypoShortcut")
        defaults!.set(shortcuts[2], forKey: "wordDeletionShortcut")
        defaults!.set(shortcuts[3], forKey: "cursorShortcut")
        defaults!.synchronize()
    }
    
    public func update(value: Any, key: String) {
        defaults!.set(value, forKey: key)
        defaults!.synchronize()
    }
}
