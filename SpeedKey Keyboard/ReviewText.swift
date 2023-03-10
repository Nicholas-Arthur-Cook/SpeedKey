//
//  ReviewText.swift
//  SpeedKey Keyboard
//
//  Created by Chloe Snyders on 2/16/23.
//

import Foundation
import SwiftUI
import AVFoundation


class Speaker: NSObject, AVSpeechSynthesizerDelegate {
    let synthesizer = AVSpeechSynthesizer()
    
    
    override init() {
        super.init()
        let voices = AVSpeechSynthesisVoice.speechVoices()
        print(voices)
        synthesizer.delegate = self
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Fail to enable session")
        }
    }

    
    func speak(msg: String) {
        let utterance = AVSpeechUtterance(string: msg)

        //utterance.rate = 0.57
        //utterance.pitchMultiplier = 0.8
        //utterance.postUtteranceDelay = 0.2
        //utterance.volume = 0.8

        let voice = AVSpeechSynthesisVoice(language: "en-US")

        utterance.voice = voice
        synthesizer.speak(utterance)
    }
}


// NOTE: WHEN SELECTING KEYBOARD, USER NEEDS TO GIVE "FULL ACCESS" OR WILL NOT WORK
// TODO: investigate to see if there is a fix for above dependency
class ReviewText {
     
    let speaker = Speaker()
 

    func reviewPreviousWords(precedingText: String, count: Int) {
        print("reviewPreviousWords was called")
        let split = precedingText.split(separator: " ")
        let lastWords = String(split.suffix(count).joined(separator: [" "]))
        print("words to say: ", lastWords)
        speaker.speak(msg: lastWords)
     }
 
    
     func reviewEntireText(proxy: UITextDocumentProxy) {
         print("reviewEntireText was called")
         let precedingText = proxy.documentContextBeforeInput ?? ""
         speaker.speak(msg: precedingText)
     }
 
 }

