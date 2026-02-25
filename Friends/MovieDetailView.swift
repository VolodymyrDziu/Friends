//
//  MovieDetailView.swift
//  Friends
//
//  Created by Volodymyr Dziubenko on 24.02.2026.
//

import SwiftUI

struct MovieDetailView: View {
    @Bindable var movie: Movie
    let isNew: Bool
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    init(movie: Movie, isNew: Bool) {
        self.movie = movie
        self.isNew = isNew
    }
    
    var sortedFriends: [Friend] {
        movie.fovoritBy.sorted {first, second in
            first.name < second.name
        }
    }
    
    var body: some View {
        Form {
            TextField("Title", text: $movie.title)
               
            DatePicker("Relise Date", selection: $movie.releaseDate, displayedComponents: .date)
            
            if !movie.fovoritBy.isEmpty {
                Section("Favorite by"){
                    ForEach(sortedFriends) { friend in
                        Text(friend.name)
                    }
                    
                }
            }
        }
        .navigationTitle( isNew ? "New movie" : "Movie")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if isNew {
                ToolbarItem (placement: .confirmationAction){
                    Button("Save"){
                        dismiss()
                    }
                }
                ToolbarItem (placement: .cancellationAction){
                    Button("Cancel"){
                        modelContext.delete(movie)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        MovieDetailView(movie: SampleData.shared.movie, isNew: true)
    }
}
