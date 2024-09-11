//
//  Configuration.swift
//  The Spy
//
//  Created by Julian Schumacher on 11.09.24.
//

import Foundation
import SwiftData

@Model
internal class Configuration {
    
    @Attribute(.unique) internal var unselectedCategories : [String]
    
    internal init(selectedCategories: [String] = []) {
        self.unselectedCategories = selectedCategories
    }
}
