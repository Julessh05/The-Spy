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
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Number Player", text: $numberPlayer)
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
            }
            .navigationTitle("New Game")
            .toolbarRole(.automatic)
            .toolbar(.automatic, for: .automatic)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("OK") {
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

    ConfigSheet(
        numberPlayer: $numberPlayer,
        numberSpies: $numberSpies,
        rolesShowing: $rolesShowing
    )
}
