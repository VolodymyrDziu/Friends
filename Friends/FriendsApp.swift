//
//  FriendsApp.swift
//  Friends
//
//  Created by Volodymyr Dziubenko on 21.02.2026.
//

import SwiftUI
import SwiftData

@main
struct FriendsApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [Friend.self, Movie.self])
        }
       
    }
}
