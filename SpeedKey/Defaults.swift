//
//  Defaults.swift
//  SpeedKey
//
//  Created by Chloe Snyders on 3/19/23.
//

import Foundation

class Settings: ObservableObject {
    
    @Published var speedKeyOn = false
    @Published var autoDeleteOn = false
    @Published var typoNotificationOn = false
    @Published var reviewPreivousWordsOn = false
    
    @Published var notificationType = "Vibrate"
    @Published var previousWordReviewCount = "5"
    
    @Published var entireTextReviewShortcut = Shortcut.sideButton
    @Published var jumpToTypoShortcut = Shortcut.doubleTap
    @Published var wordDeletionShortcut = Shortcut.swipeAcross
    @Published var cursorShortcut = Shortcut.swipeUp
    
    public init() {}

}


class Defaults {
    let defaults = UserDefaults(suiteName: "group.eecs495.SpeedKey")
    
    public init() {
        print("init defaults")
        defaults!.set(false, forKey: "speedKeyOn")
        defaults!.set(false, forKey: "autoDeleteOn")
        defaults!.set(false, forKey: "typoNotificationOn")
        defaults!.set(false, forKey: "reviewPreivousWordsOn")
        defaults!.set("Vibrate", forKey: "notificationType")
        defaults!.set("5", forKey: "previousWordReviewCount")
        defaults!.set(Shortcut.sideButton, forKey: "entireTextReviewShortcut")
        defaults!.set(Shortcut.doubleTap, forKey: "jumpToTypoShortcut")
        defaults!.set(Shortcut.swipeAcross, forKey: "wordDeletionShortcut")
        defaults!.set(Shortcut.swipeUp, forKey: "cursorShortcut")
        defaults!.synchronize()
    }
    
    public func update(value: Any, key: String) {
        print("updated ", key)
        defaults!.set(value, forKey: key)
        defaults!.synchronize()
    }
}
