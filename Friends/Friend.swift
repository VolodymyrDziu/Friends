//
//  Friend.swift
//  Friends
//
//  Created by Volodymyr Dziubenko on 21.02.2026.
//

import Foundation
import SwiftData

@Model
class Friend {
    var name: String
    var birthday: Date
    
    init(name: String, birthday: Date) {
        self.name = name
        self.birthday = birthday
    }
}
