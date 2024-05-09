//
//  ContentView.swift
//  The Spy
//
//  Created by Julian Schumacher on 08.05.24.
//

import SwiftUI
import SwiftData

internal struct ContentView: View {
    
    @State private var gameRunning : Bool = false
    
    var body: some View {
        NavigationSplitView {
            if gameRunning {
                GameView(gameRunning: $gameRunning)
            } else {
                VStack {
                    NavigationLink("New Game") {
                        GameConfig(gameRunning: $gameRunning)
                    }
                    .navigationTitle("Welcome")
#if !os(macOS)
                    .navigationBarTitleDisplayMode(.automatic)
#endif
                }
            }
        } detail: {
            Text("Nothing to see here yet...")
        }
    }
}

#Preview {
    ContentView()
}
