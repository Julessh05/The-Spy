//
//  GameView.swift
//  The Spy
//
//  Created by Julian Schumacher on 09.05.24.
//

import SwiftUI

internal struct GameView: View {
    
    @Binding internal var gameRunning : Bool
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var minutes : Int = 1
    
    @State private var seconds : Int = 0
    
    @State private var gameOverDialog : Bool = false
    
    var body: some View {
        VStack {
            Text("Timer")
            Text("\(String(minutes)):\(String(seconds))")
            Button("Done") {
                gameRunning.toggle()
            }
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
                seconds = 60
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
