//
//  ContentView.swift
//  The Spy
//
//  Created by Julian Schumacher on 08.05.24.
//

import SwiftUI
import SwiftData

internal struct ContentView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var gameRunning : Bool = false
    
    var body: some View {
        NavigationSplitView {
            if gameRunning {
                GameView(gameRunning: $gameRunning)
            } else {
                VStack {
                    NavigationLink {
                        GameConfig(gameRunning: $gameRunning)
                    } label: {
                        Text("New Game")
                            .foregroundStyle(colorScheme == .dark ? .white : .black)
                            .frame(width: 210, height: 70)
                            .background(in: .rect(cornerRadius: 20), fillStyle: .init(eoFill: true, antialiased: true))
                            .backgroundStyle(colorScheme == .dark ? .gray : .blue)
                    }
                    .padding(.vertical, 10)
                    NavigationLink {
                        CategoryViewer()
                    } label: {
                        Text("Categories")
                            .foregroundStyle(colorScheme == .dark ? .white : .black)
                            .frame(width: 210, height: 70)
                            .background(in: .rect(cornerRadius: 20), fillStyle: .init(eoFill: true, antialiased: true))
                            .backgroundStyle(colorScheme == .dark ? .gray : .blue)
                    }
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
