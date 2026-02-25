//
//  SampleData.swift
//  Friends
//
//  Created by Volodymyr Dziubenko on 23.02.2026.
//

import Foundation
import SwiftData

@MainActor
class SampleData {
  
    static let shared = SampleData()
   
    let modelContainer: ModelContainer
   
    
    var context: ModelContext {
        modelContainer.mainContext
    }
    
    var friend: Friend {
        Friend.sampleData.first!
    }
    
    var movie: Movie {
        Movie.sampleData.first!
    }
    
    private init() {
        let schema = Schema([
            Friend.self,
            Movie.self,
        ])
        
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        
        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            
            inserSampleData()
            try context.save()
            
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    private func inserSampleData(){
        for friend in Friend.sampleData {
            context.insert(friend)
        }
        for movie in Movie.sampleData {
            context.insert(movie)
        }
        
        Friend.sampleData[0].favoritMovie = Movie.sampleData[1]
        Friend.sampleData[2].favoritMovie = Movie.sampleData[0]
        Friend.sampleData[3].favoritMovie = Movie.sampleData[4]
        Friend.sampleData[4].favoritMovie = Movie.sampleData[2]
    }
}
