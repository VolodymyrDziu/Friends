//
//  Item.swift
//  Friends
//
//  Created by Volodymyr Dziubenko on 21.02.2026.
//

import Foundation
import SwiftData

@Model
 class Movie {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
