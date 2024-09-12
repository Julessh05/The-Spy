//
//  SettingsHandler.swift
//  The Spy
//
//  Created by Julian Schumacher on 12.09.24.
//

import Foundation

internal struct SettingsHandler {
    
    private static let appVersion = "app_version_preference"
    
    private static let buildVersion = "build_version_preference"
    
    internal static func loadSettings() -> Void {
        updateValues()
    }
    
    private static func updateValues() -> Void {
        UserDefaults.standard.set(Bundle.main.infoDictionary!["CFBundleShortVersionString"], forKey: appVersion)
        UserDefaults.standard.set(Bundle.main.infoDictionary!["CFBundleVersion"], forKey: buildVersion)
    }
}
