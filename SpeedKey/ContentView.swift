//
//  ContentView.swift
//  SpeedKey
//
//  Created by Nick Cook on 2/2/23.
//

import SwiftUI

struct ContentView: View {
    
    enum Labels: String, CaseIterable, Identifiable {
        case speedKey = "SpeedKey App"
        case welcomeMessage = "Welcome to SpeedKey! The fast and accurate typing keyboard!"
        case settingsMenu = "Settings Menu"
        case practiceMode = "Enter Practice Mode"
        case learnMore = "Learn More About SpeedKey"
        var id: Self { self }
    }
    
    var body: some View {
            VStack {
                Text("SpeedKey")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hue: 0.547, saturation: 0.571, brightness:0.819))
                    .padding([.bottom], 20)
                    .accessibilityLabel(Labels.speedKey.rawValue)
                    
                NavigationView {
                        
                    VStack {
                            
                        Text("Welcome to SpeedKey! The fast and accurate typing keyboard!")
                            .multilineTextAlignment(.center)
                            .font(.subheadline)
                            .padding([.bottom], 60)
                            .accessibilityLabel(Labels.welcomeMessage.rawValue)
                        
                        NavigationLink(destination: SettingsMenu()) {
                            Text("Settings")
                                .accessibilityLabel(Labels.settingsMenu.rawValue)
                        }
                        .padding([.bottom], 60)
                        
                        NavigationLink(destination: PracticeMode()) {
                            Text("Practice Mode")
                                .accessibilityLabel(Labels.practiceMode.rawValue)
                        }
                        .padding([.bottom],60)
                    
                        NavigationLink(destination: LearnMore()) {
                            Text("Learn More About SpeedKey")
                                .accessibilityLabel(Labels.learnMore.rawValue)
                        }
                        
                    } // VStack
                    
                } // NavigationView

        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
