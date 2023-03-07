//
//  ReviewText.swift
//  SpeedKey Keyboard
//
//  Created by Chloe Snyders on 2/16/23.
//

import Foundation
import SwiftUI
import SpeedKey

// review 5,10,15 words based on settings
// review entire text based on shortcut from settings

 class ReviewText {
 
     func reviewPreviousWords(proxy: UITextDocumentProxy) {
         var precedingText = proxy.documentContextBeforeInput ?? ""
         
     }
 
     func reviewEntireText(proxy: UITextDocumentProxy) {
         var precedingText = proxy.documentContextBeforeInput ?? ""
 
     }
 
 }

