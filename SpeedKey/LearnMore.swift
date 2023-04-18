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
                    .padding(10)
                
                Section { // About the app
                    Text("About the app").font(.title2).foregroundColor(.cyan)
                    Spacer()
                    Text("SpeedKey is an iOS application that provides proofreading settings and shortcuts that integrate into a custom keyboard.")
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                    //Spacer()
                        .padding(5)
                    Text("SpeedKey aims to provide an accessible keyboard that increases user typing speed, while maintaining text accuracy.")
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                }
                Spacer()
                Spacer()
                    .padding(10)
                Section { // Settings options
                    Text("Settings Options").font(.title2).foregroundColor(.cyan)
                    Spacer()
                    Spacer()
                        //.padding(5)
                    Section {
                        Text("Typo settings").font(.title3)
                        Text("Enabling auto-delete on typo will automatically delete mispelled words.")
                            .fixedSize(horizontal: false, vertical: true)
                        Spacer()
                        Text("Enabling typo notification and notification type will inform user a word was mispelled through a vibration or ding sound.")
                            .fixedSize(horizontal: false, vertical: true)
                        Spacer()
                        Text("Specify frequently used typos for the keyboard to ignore when analyzing text. Could include names not recognized by the dictionary, acronyms, and more.")
                            .fixedSize(horizontal: false, vertical: true)
                        
                    }
                    Spacer()
                        .padding(5)
                    Section {
                        Text("Text review").font(.title3)
                        Text("Enabling automatic review of typed text will automatically review typed text every character, word, 5 words, 10 words, 15 words, or sentence based on user preference.")
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    Spacer()
                        .padding(5)
                    Section {
                        Text("Gestures").font(.title2)
                        Text("Available gestures include swipe up, swipe down, swipe left, and swipe right, and each gesture may be chosen at most once.")
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    Spacer()
                        .padding(5)
                    
                    
                    // SHORTCUTS
                    Section {
                        Text("Shortcuts").font(.title2).foregroundColor(.cyan)
                            .padding(10)
                        
                        Text("Review entire text").bold().fixedSize(horizontal: false, vertical: true)
                        Text("Speak aloud all typed text.")

                            .padding(5)
                        Text("Jump to typo").fixedSize(horizontal: false, vertical: true).bold()
                        Text("Move the cursor automatically to the end of the most recent mispelled word.")
                            .padding(5)
                        Text("Word deletion").fixedSize(horizontal: false, vertical: true).bold()
                        Text("Automatically delete the most recently typed word.")
                            .padding(5)
                        Text("Move cursor to end").fixedSize(horizontal: false, vertical: true).bold()
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
