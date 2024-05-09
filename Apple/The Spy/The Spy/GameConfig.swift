//
//  GameConfig.swift
//  The Spy
//
//  Created by Julian Schumacher on 08.05.24.
//

import SwiftUI

internal struct GameConfig: View {
    
    @State private var numberPlayer : String = "2"
    
    @State private var numberSpies : String = "1"
    
    var body: some View {
        VStack {
            TextField("Number of Players", text: $numberPlayer)
            TextField("Number of Spies", text: $numberSpies)
            NavigationLink("Start") {
                RoleViewer(
                    numberPlayer: Int(numberPlayer)!,
                    numberSpies: Int(numberSpies)!
                )
            }
        }
        .textFieldStyle(.roundedBorder)
        .padding(.all, 24)
        .navigationTitle("New Game")
#if !os(macOS)
        .navigationBarTitleDisplayMode(.automatic)
#endif
    }
}

#Preview {
    GameConfig()
}
