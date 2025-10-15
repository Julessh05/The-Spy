//
//  Player.swift
//  The Spy
//
//  Created by Julian Schumacher on 14.09.25.
//  Copyright © 2025 Julian Schumacher. All rights reserved.
//

import Foundation
import SwiftData

@Model
internal class Player {
    
    internal var name : String
    
    internal var id : UUID
    
    internal init(name: String) {
        self.name = name
        id = UUID()
    }
}
