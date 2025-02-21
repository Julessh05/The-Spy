//
//  The_SpyApp.swift
//  The Spy
//
//  Created by Julian Schumacher on 08.05.24.
//

import SwiftUI
import SwiftData

@main
struct The_SpyApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Configuration.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    internal init() {
        SettingsHandler.loadSettings()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
