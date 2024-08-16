//
//  GameConfig.swift
//  The Spy
//
//  Created by Julian Schumacher on 08.05.24.
//

import SwiftUI

internal struct GameConfig: View {
    
    @State private var numberPlayer : String = ""
    
    @State private var numberSpies : String = ""
    
    @Binding internal var gameRunning : Bool
    
    var body: some View {
        VStack {
            Section("Player") {
                TextField("Number of Players", text: $numberPlayer, prompt: Text("How many peolpe are playing?"))
            }
            Section("Spies") {
                TextField("Number of Spies", text: $numberSpies, prompt: Text("How many spies should be there?"))
            }
            NavigationLink("Start") {
                if !numberSpies.isEmpty && !numberPlayer.isEmpty {
                    RoleViewer(
                        numberPlayer: Int(numberPlayer)!,
                        numberSpies: Int(numberSpies)!,
                        gameRunning: $gameRunning
                    )
                }
            }
            .disabled(numberSpies.isEmpty || numberPlayer.isEmpty || numberPlayer <= numberSpies)
        }
        .keyboardType(.numberPad)
        .textContentType(.none)
        .textFieldStyle(.roundedBorder)
        .padding(.all, 24)
        .navigationTitle("New Game")
#if !os(macOS)
        .navigationBarTitleDisplayMode(.automatic)
#endif
    }
}

internal struct GameConfigPreview : PreviewProvider {
    @State internal static var gameRunning : Bool = false
    
    static var previews: some View {
        GameConfig(gameRunning: $gameRunning)
    }
}
