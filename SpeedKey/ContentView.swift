//
//  ContentView.swift
//  SpeedKey
//
//  Created by Nick Cook on 2/2/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
            VStack {
                Text("SpeedKey")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hue: 0.547, saturation: 0.571, brightness:0.819))
                    .padding([.bottom], 20)
                    
                NavigationView {
                        
                    VStack {
                            
                        Text("Welcome to SpeedKey! The fast and accurate typing keyboard!")
                            .multilineTextAlignment(.center)
                            .font(.subheadline)
                            .padding([.bottom], 60)
                        
                        NavigationLink(destination: SettingsMenu()) {
                            Text("Enable SpeedKey")
                        }
                        .padding([.bottom], 60)
                        
                        NavigationLink(destination: PracticeMode()) {
                            Text("Practice Mode")
                        }
                        .padding([.bottom],60)
                    
                        NavigationLink(destination: LearnMore()) {
                            Text("Learn More About SpeedKey")
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
