//
//  LearnMore.swift
//  SpeedKey
//
//  Created by Chloe Snyders on 2/8/23.
//

import Foundation
import SwiftUI

struct LearnMore: View {
    var body: some View {
        VStack {
            ScrollView {
                Text("Learn More").font(.title)
                Spacer()
                Spacer()
                Section { // About the app
                    Text("About the app").font(.title2)
                    Spacer()
                    Text("SpeedKey is an iOS application that provides proofreading settings and shortcuts that integrate into a custom keyboard.")
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                    Text("SpeedKey aims to provide an accessible keyboard that increases user typing speed, while maintaining text accuracy.")
                        .fixedSize(horizontal: false, vertical: true)
                }
                Spacer()
                Spacer()
                Section { // Settings options
                    Text("Settings options").font(.title2)
                    Spacer()
                    Section {
                        Text("Typo settings").font(.title3)
                        Text("Enabling auto-delete on typo will automatically delete mispelled words.")
                            .fixedSize(horizontal: false, vertical: true)
                        Spacer()
                        Text("Enabling typo notification and notification type will inform user a word was mispelled through a vibration or ding sound.")
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    Spacer()
                    Section {
                        Text("Text review").font(.title3)
                        Text("Enabling automatic review of typed text will automatically review typed text every character, word, 5 words, 10 words, 15 words, or sentence based on user preference.")
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    Spacer()
                    Section {
                        Text("Gestures").font(.title3)
                        Text("Available gestures include swipe up, swipe down, swipe left, and swipe right, and each gesture may be chosen at most once.")
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    Spacer()
                    Section {
                        Text("Shortcuts").font(.title3)
                        Text("Review entire text").font(.headline)
                        Text("Speak aloud all typed text.")
                        Text("Jump to typo").font(.headline)
                        Text("Move the cursor automatically to the end of the most recent mispelled word.")
                        Text("Word deletion").font(.headline)
                        Text("Automatically delete the most recently typed word.")
                        Text("Move cursor to end").font(.headline)
                        Text("Automatically move the cursor to the end of the typed text.")
                    }
                }
                Spacer()
                Spacer()
                Section { // Keyboard specific features
                    Text("Keyboard specific features").font(.title2)
                    Spacer()
                    Text("Long press on space bar will reveal another keyboard with numbers and special characters.")
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }
}
