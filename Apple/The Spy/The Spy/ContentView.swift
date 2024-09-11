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
    
    @State private var rolesShowing : Bool = false
    
    @State private var numberPlayer : String = ""
    
    @State private var numberSpies : String = ""
    
    @State private var configSheetShown : Bool = false
    
    var body: some View {
        NavigationSplitView {
            if gameRunning {
                GameView(gameRunning: $gameRunning)
                    .onAppear {
                        rolesShowing = false
                        numberSpies = ""
                        numberPlayer = ""
                    }
            } else if rolesShowing {
                RoleViewer(numberPlayer: Int(numberPlayer)!, numberSpies: Int(numberSpies)!, gameRunning: $gameRunning)
            } else {
                VStack {
                    Button {
                        configSheetShown.toggle()
                    } label: {
                        Text("New Game")
                            .foregroundStyle(colorScheme == .dark ? .white : .black)
                            .frame(width: 210, height: 70)
                            .background(in: .rect(cornerRadius: 20), fillStyle: .init(eoFill: true, antialiased: true))
                            .backgroundStyle(colorScheme == .dark ? .gray : .blue)
                    }
                    NavigationLink {
                        CategoryViewer()
                    } label: {
                        Text("Categories")
                            .foregroundStyle(colorScheme == .dark ? .white : .black)
                            .frame(width: 210, height: 70)
                            .background(in: .rect(cornerRadius: 20), fillStyle: .init(eoFill: true, antialiased: true))
                            .backgroundStyle(colorScheme == .dark ? .gray : .blue)
                    }
                    .padding(.vertical, 10)
//                    NavigationLink {
//                        Configuration()
//                    } label: {
//                        Text("Further Config")
//                            .foregroundStyle(colorScheme == .dark ? .white : .black)
//                            .frame(width: 210, height: 70)
//                            .background(in: .rect(cornerRadius: 20), fillStyle: .init(eoFill: true, antialiased: true))
//                            .backgroundStyle(colorScheme == .dark ? .gray : .blue)
//                    }
                }
                .navigationTitle("Welcome")
#if !os(macOS)
                .navigationBarTitleDisplayMode(.automatic)
#endif
                .sheet(isPresented: $configSheetShown) {
                    NavigationStack {
                        Form {
                            TextField("Number Player", text: $numberPlayer)
                            TextField("Number Spies", text: $numberSpies)
                        }
                        .navigationTitle("New Game")
                        .toolbarRole(.automatic)
                        .toolbar(.automatic, for: .automatic)
                        .toolbar {
                            ToolbarItem(placement: .primaryAction) {
                                Button("Ok") {
                                    rolesShowing.toggle()
                                    configSheetShown.toggle()
                                }
                                .disabled(Int(numberSpies) ?? 0 >= Int(numberPlayer) ?? 0 || numberSpies.isEmpty || numberPlayer.isEmpty)
                            }
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel", role: .cancel) {
                                    configSheetShown.toggle()
                                }
                            }
                        }
                    }
                }
                .textFieldStyle(.automatic)
                .textCase(.none)
                .keyboardType(.numberPad)
            }
        } detail: {
            Text("Nothing to see here yet...")
        }
    }
}

#Preview {
    ContentView()
}
