//
//  RoleViewer.swift
//  The Spy
//
//  Created by Julian Schumacher on 08.05.24.
//

import SwiftUI

internal struct RoleViewer: View {
    
    internal init(numberPlayer : Int, numberSpies : Int) {
        self.numberPlayer = numberPlayer
        word = "Loaded Word"
        spyNumbers = []
        for _ in 0...numberSpies {
            spyNumbers.append(Int.random(in: 1...playerCounter))
        }
        do {
            let json = try JSONSerialization.jsonObject(with: NSDataAsset(name: "Words")!.data, options: [.topLevelDictionaryAssumed]) as! [String : [String]]
            let category = json.randomElement()!
            word = category.value.randomElement()!
        } catch {
            // TODO: handle error
        }
    }
    
    @State private var hidden : Bool = true
    
    private let numberPlayer : Int
    
    private var word : String
    
    @State private var playerCounter : Int = 1
    
    private var spyNumbers : [Int]
    
    @State private var textToShow : String = ""
    
    var body: some View {
        Button {
            btnTap()
        } label: {
            if hidden {
                Text("Tap to show")
            } else {
                VStack {
                    Text(textToShow)
                    Text("Tap to hide again")
                }
            }
        }
        .navigationTitle("Roles")
#if !os(macOS)
        .navigationBarTitleDisplayMode(.automatic)
#endif
        .foregroundStyle(.primary)
    }
    
    private func btnTap() -> Void {
        if spyNumbers.contains(playerCounter) {
            textToShow = "You're a Spy"
        } else if playerCounter > numberPlayer {
            // TODO: exit
        } else {
            textToShow = word
        }
        playerCounter += 1
        hidden.toggle()
    }
}

#Preview {
    RoleViewer(numberPlayer: 4, numberSpies: 1)
}
