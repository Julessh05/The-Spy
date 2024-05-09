//
//  RoleViewer.swift
//  The Spy
//
//  Created by Julian Schumacher on 08.05.24.
//

import SwiftUI

internal struct RoleViewer: View {
    
    private var gameRunning : Binding<Bool>
    
    @Environment(\.dismiss) private var dismiss
    
    internal init(numberPlayer : Int, numberSpies : Int, gameRunning : Binding<Bool>) {
        self.gameRunning = gameRunning
        self.numberPlayer = numberPlayer
        self.numberSpies = numberSpies
        word = "Loaded Word"
        spyNumbers = []
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
    
    private let numberSpies : Int
    
    private var word : String
    
    @State private var playerCounter : Int = 1
    
    @State private var spyNumbers : [Int]
    
    @State private var textToShow : String = ""
    
    var body: some View {
        Button {
            btnTap()
        } label: {
            if playerCounter > numberPlayer {
              Text("Tap to start")
            } else if hidden {
                Text("Tap to show")
            } else {
                VStack {
                    Text(textToShow)
                    Text("Tap to hide again")
                }
            }
        }
        .onAppear {
            for _ in 1...numberSpies {
                var rm = Int.random(in: 1...numberPlayer)
                while spyNumbers.contains(rm) {
                    rm = Int.random(in: 1...numberPlayer)
                }
                spyNumbers.append(rm)
                print(spyNumbers)
            }
        }
        .navigationTitle("Roles")
#if !os(macOS)
        .navigationBarTitleDisplayMode(.automatic)
#endif
        .foregroundStyle(.primary)
    }
    
    private func btnTap() -> Void {
        guard hidden else {
            hidden.toggle()
            playerCounter += 1
            return
        }
        if spyNumbers.contains(playerCounter) {
            textToShow = "You're a Spy"
        } else if playerCounter > numberPlayer {
            gameRunning.wrappedValue = true
            dismiss()
        } else {
            textToShow = word
        }
        hidden.toggle()
    }
}

internal struct RoleViewerPreview : PreviewProvider {
    @State internal static var gameRunning : Bool = false
    
    static var previews: some View {
        RoleViewer(numberPlayer: 4, numberSpies: 1, gameRunning: $gameRunning)
    }
}
