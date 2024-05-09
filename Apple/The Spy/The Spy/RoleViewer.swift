//
//  RoleViewer.swift
//  The Spy
//
//  Created by Julian Schumacher on 08.05.24.
//

import SwiftUI

internal struct RoleViewer: View {
    
    internal init(numberPlayer : Int, numberSpies : Int) {
        print(String(data: NSDataAsset(name: "Words")!.data, encoding: .utf8))
        word = "Test word"
    }
    
    @State private var hidden : Bool = true
    
    internal let word : String
    
    @State private var playerCounter : Int = 1
    
    var body: some View {
        Button {
            btnTap()
        } label: {
            if hidden {
                Text("Tap to show")
            } else {
                VStack {
                    Text(word)
                    Text("Tap to hide again")
                }
            }
        }
        .navigationTitle("Roles")
#if !os(macOS)
        .navigationBarTitleDisplayMode(.automatic)
#endif
        .foregroundStyle(.primary)
    }
    
    private func btnTap() -> Void {
        hidden.toggle()
    }
}

#Preview {
    RoleViewer(numberPlayer: 4, numberSpies: 1)
}
