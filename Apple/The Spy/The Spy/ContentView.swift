//
//  ContentView.swift
//  The Spy
//
//  Created by Julian Schumacher on 08.05.24.
//

import SwiftUI
import SwiftData

internal struct ContentView: View {
    
    var body: some View {
        NavigationSplitView {
            VStack {
                NavigationLink("New Game") {
                    GameConfig()
                }
                .navigationTitle("Welcome")
#if !os(macOS)
                .navigationBarTitleDisplayMode(.automatic)
#endif
            }
        } detail: {
            Text("Nothing to see here yet...")
        }
    }
}

#Preview {
    ContentView()
}
