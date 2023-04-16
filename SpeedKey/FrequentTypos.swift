//
//  FrequentTypos.swift
//  SpeedKey
//
//  Created by Chloe Snyders on 4/13/23.
//

import Foundation
import SwiftUI

var typos: [String] = []

struct FrequentTypos: View {
    
    @State var enteredFreqTypo: String = ""
    
    @State var currentFreqTypo = ""
    
    func getFreqTypos() -> [String] {
        return userDefaults?.object(forKey: "freqTypos") as? [String] ?? []
    }
    
    func deleteFromDefaults() -> Void {
        if let index = typos.firstIndex(of: currentFreqTypo) {
            typos.remove(at: index)
        }
        userDefaults!.set(typos, forKey: "freqTypos")
    }
    
    
    var body: some View {
        VStack {
            Section {
                if !getFreqTypos().isEmpty {
                    Text("Stored frequently used typos that keyboard will ignore").font(.headline)
                    Text("Swipe to delete").font(.subheadline)
                    
                    List {
                        ForEach(getFreqTypos(), id: \.self) {
                            Text($0)
                        } // ForEach
                        .onDelete { indices in
                            typos.remove(atOffsets: indices)
                            userDefaults!.set(typos, forKey: "freqTypos")
                        }
                    }
                    
                } else {
                    Text("No stored frequent typos that keyboard will ignore").font(.headline)
                }
            } // Section
            
            Spacer()
            
            Section {
                Text("Enter frequently used typos below").font(.headline)
                Text("Not case sensitive").font(.subheadline)
                TextField("Frequent typo",
                          text: $enteredFreqTypo)
                Button(action: {
                    // Add typo to list, update UserDefaults
                    if !getFreqTypos().contains(enteredFreqTypo) {
                        typos.append(enteredFreqTypo.lowercased())
                        userDefaults!.set(typos, forKey: "freqTypos")
                    }
                    enteredFreqTypo = ""
                }) {
                    Text("Enter")
                }
            } // Section
        } // VStack
        .padding()
    }
}
