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
                
                HStack {
                    Text("Welcome to SpeedKey! The fast and accurate typing keyboard!")
                        .multilineTextAlignment(.center)
                        .font(.subheadline)
                        .padding([.bottom], 60)
                    
                    
                    
                }
                
                VStack {
        
                    Button(
                        "Enable SpeedKey",
                        action: {
                            //some code
                            print("Sup")
                        }
                        )
                    
                    .padding([.bottom], 60)
                    Button (
                        "Practice Mode",
                        action: {
                            //some code
                            print("Working on it")
                        }
                    )
                    .padding([.bottom],60)
                    Button(
                        "Learn More about SpeedKey",
                        action: {
                            //code
                            print("To-Do")
                        })
                    
                    
                }// VStack
                        
                    
                    
                
               
               
            }

      
          
            
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
