//
//  ContentView.swift
//  The Spy
//
//  Created by Julian Schumacher on 08.05.24.
//

import SwiftUI
import SwiftData
import GameKit

internal struct ContentView: View {
    
    @Query private var configs : [Configuration]
    
    @Environment(\.modelContext) private var modelContext
    
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var gameRunning : Bool = false
    
    @State private var rolesShowing : Bool = false
    
    @State private var numberPlayer : String = ""
    
    @State private var numberSpies : String = ""
    
    @State private var configSheetShown : Bool = false
    
    private var viewController : UIViewController?
    
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
                    NavigationLink {
                        ConfigView()
                    } label: {
                        Text("Further Configuration")
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
                .sheet(isPresented: $configSheetShown) {
                    NavigationStack {
                        Form {
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
                                VStack {
                                    Text("Enter the number of spies among the player\nThe number of spies must be smaller than the number of total players")
                                }
                            }
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
        .onAppear {
            if configs.isEmpty {
                let config = Configuration()
                modelContext.insert(config)
            } else if configs.count > 1 {
                print("More than one config model")
            }
            authenticateUser()
        }
        .onChange(of: gameRunning) {
            guard !gameRunning else { return }
            GKAchievement.loadAchievements {
                achievements, error in
                let firstGameID = "first_game"
                guard !(achievements?.contains(where: { $0.identifier == firstGameID }) ?? true) else { return }
                let achievement = GKAchievement(identifier: firstGameID)
                achievement.percentComplete = 100
                let achievementsToReport : [GKAchievement] = [achievement]
                GKAchievement.report(achievementsToReport)
            }
        }
    }
    
    //https://www.asushil.com.np/setting-up-game-center-authentication-in-swiftui-a-comprehensive-guide/
    /// Authenticates the User in the Game Center
    private func authenticateUser() -> Void {
        GKLocalPlayer.local.authenticateHandler = {
            vc, error  in
            guard !GKLocalPlayer.local.isAuthenticated else { return }
            if let view = vc {
                viewController?.present(view, animated: true)
            }
            if let e = error {
                print(e)
            }
        }
    }
}



#Preview {
    ContentView()
        .modelContainer(previewModelContainer)
}

private var previewModelContainer: ModelContainer = {
    let schema = Schema([
        Configuration.self
    ])
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
    
    do {
        return try ModelContainer(for: schema, configurations: [modelConfiguration])
    } catch {
        fatalError("Could not create ModelContainer: \(error)")
    }
}()
