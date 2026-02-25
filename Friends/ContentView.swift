//
//  ContentView.swift
//  Friends
//
//  Created by Volodymyr Dziubenko on 21.02.2026.
//


import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var movie: [Movie]
        
    var body: some View {
        NavigationView {
          
            TabView {
                Tab("Friends", systemImage: "person") {
                    FriendListView()
                }
                Tab("movies", systemImage: "film.stack"){
                    FilteredMovieList()
                }
            }
        }
    }
    
    
}

#Preview {
    ContentView()
        .modelContainer(for: Friend.self, inMemory: true)
}
