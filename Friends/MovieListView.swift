//
//  MovieListView.swift
//  Friends
//
//  Created by Volodymyr Dziubenko on 23.02.2026.
//

import SwiftUI
import SwiftData

struct MovieListView: View {
    
    @Query private var movies: [Movie]
    @Environment(\.modelContext) private var modelContext
    
    @State private var newMovie: Movie?
    
    init( titleFilter: String = "" ){
        let predicate = #Predicate<Movie> { movie in
            titleFilter.isEmpty || movie.title.localizedStandardContains(titleFilter)
        }
        
        _movies = Query(filter: predicate, sort: \Movie.title)
    }
    
    var body: some View {

        Group {
            if !movies.isEmpty {
                List {
                    ForEach(movies){movie in
                        NavigationLink(movie.title) {
                            MovieDetailView(movie: movie, isNew: true)
                        }
                        
                    }
                    .onDelete(perform: deleteMovie(indexes: ))
                }
            } else {
                ContentUnavailableView("Add movies", systemImage: "film.stack")
            }
        }
            .navigationTitle("Movies")
            .toolbar {
                ToolbarItem {
                    Button("Add", systemImage: "plus", action: addMovie)
                }
                ToolbarItem {
                    EditButton()
                }
            }
            .sheet(item: $newMovie) { movie in
                NavigationStack {
                    MovieDetailView(movie: movie, isNew: true)
                }
                .interactiveDismissDisabled()
            }
        
    }
    
    private func addMovie(){
        let newMovie = Movie(title: "", releaseDate: .now)
        modelContext.insert(newMovie)
        self.newMovie = newMovie
        
    }
    
    private func deleteMovie(indexes: IndexSet){
        withAnimation {
            for index in indexes {
                modelContext.delete(movies[index])
            }
        }
    }
}

#Preview {
    NavigationStack {
        MovieListView()
            .modelContainer(SampleData.shared.modelContainer)
    }
}
