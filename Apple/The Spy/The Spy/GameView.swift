//
//  GameView.swift
//  The Spy
//
//  Created by Julian Schumacher on 09.05.24.
//

import SwiftUI
import GameKit

internal struct GameView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    @Binding internal var gameRunning : Bool
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var minutes : Int = 5
    
    @State private var seconds : Int = 0
    
    @State private var gameOverDialog : Bool = false
    
    var body: some View {
        VStack {
            Text("Time remaining:")
                .font(.title3)
            // From: https://stackoverflow.com/questions/32338137/padding-a-swift-string-for-printing
            // Answer used for this (without extension): https://stackoverflow.com/a/69859859
            Text("\(String(String(minutes).padding(toLength: 2, withPad: "0", startingAt: 0).reversed())):\(String(String(String(seconds).reversed()).padding(toLength: 2, withPad: "0", startingAt: 0).reversed()))")
                .font(.title)
                .padding(12)
            Button {
                gameRunning.toggle()
                timer.upstream.connect().cancel()
            } label: {
                Text("Done")
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                    .frame(width: 210, height: 70)
                    .background(in: .rect(cornerRadius: 20), fillStyle: .init(eoFill: true, antialiased: true))
                    .backgroundStyle(colorScheme == .dark ? .gray : .blue)
            }
            .padding(.top, 8)
            .padding(.bottom, 2)
            Button {
                minutes += 1
            } label: {
                Label("1 minute", systemImage: "plus")
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                    .frame(width: 210, height: 70)
                    .background(in: .rect(cornerRadius: 20), fillStyle: .init(eoFill: true, antialiased: true))
                    .backgroundStyle(colorScheme == .dark ? .gray : .blue)
            }
            .padding(.top, 8)
            .padding(.bottom, 2)
        }
        .alert("Game Over", isPresented: $gameOverDialog) {
            Button("Ok") {
                gameRunning.toggle()
            }
        } message: {
            Text("The Game is over")
        }
        .onReceive(timer) {_ in
            if seconds > 0 {
                seconds -= 1
            } else if minutes > 0 {
                seconds = 59
                minutes -= 1
            } else {
                gameOverDialog.toggle()
                timer.upstream.connect().cancel()
            }
        }
        .navigationTitle("Find the Spy!")
        .navigationBarTitleDisplayMode(.automatic)
    }
}

internal struct GameViewPreview : PreviewProvider {
    @State internal static var gameRunning : Bool = false
    
    static var previews: some View {
        GameView(gameRunning: $gameRunning)
    }
}
