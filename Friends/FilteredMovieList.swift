//
//  FilteredMovieList.swift
//  Friends
//
//  Created by Volodymyr Dziubenko on 24.02.2026.
//

import SwiftUI

struct FilteredMovieList: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationSplitView {
            MovieListView(titleFilter: searchText)
                .searchable(text: $searchText)
        } detail: {
            Text("Select movie")
            .navigationTitle("Movie")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    FilteredMovieList()
}
