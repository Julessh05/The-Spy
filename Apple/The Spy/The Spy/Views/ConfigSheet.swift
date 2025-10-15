//
//  ConfigSheet.swift
//  The Spy
//
//  Created by Julian Schumacher on 15.01.25.
//

import SwiftUI

struct ConfigSheet: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding internal var numberPlayer : String
    
    @Binding internal var numberSpies : String
    
    @Binding internal var rolesShowing : Bool
    
    @State private var playerNames : [String] = Array(repeating: "", count: 2)
    
    @Binding internal var players : [Player]
    
    @State private var playerNameCache : [String] = Array(repeating: "", count: 2)
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Number Player", text: $numberPlayer)
                        .glassEffect()
                        .onChange(of: numberPlayer) {
                            guard !numberPlayer.isEmpty else { return }
                            playerNames = Array(
                                repeating: "",
                                count: Int(numberPlayer) ?? 2
                            )
                            for i in 0..<playerNameCache.count {
                                guard i < playerNames.count else { return }
                                playerNames[i] = playerNameCache[i]
                            }
                        }
                } header: {
                    Text("Player")
                } footer: {
                    Text("Enter the number of total players in this game")
                }
                Section {
                    TextField("Number Spies", text: $numberSpies)
                } header: {
                    Text("Spies")
                } footer: {
                    Text("Enter the number of spies among the player\nThe number of spies must be smaller than the number of total players")
                }
                Section {
                    ForEach(0..<playerNames.count, id: \.self) {
                        playerFieldNumber in
                        TextField("Playername \(playerFieldNumber + 1)", text: $playerNames[playerFieldNumber])
                    }
                } header: {
                    Text("Players")
                } footer: {
                    Text("Enter all player names")
                }
            }
            .onAppear {
                numberPlayer = "2"
                numberSpies = "1"
            }
            .navigationTitle("New Game")
            .toolbarRole(.automatic)
            .toolbar(.automatic, for: .automatic)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("OK") {
                        playerNames.forEach {
                            players.append(Player(name: $0))
                        }
                        rolesShowing.toggle()
                        dismiss()
                    }
                    .disabled(Int(numberSpies) ?? 0 >= Int(numberPlayer) ?? 0 || numberSpies.isEmpty || numberPlayer.isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    
    @Previewable @State var numberPlayer: String = "2"
    
    @Previewable @State var numberSpies: String = "1"
    
    @Previewable @State var rolesShowing: Bool = false
    
    @Previewable @State var players : [Player] = []

    ConfigSheet(
        numberPlayer: $numberPlayer,
        numberSpies: $numberSpies,
        rolesShowing: $rolesShowing,
        players: $players
    )
}
