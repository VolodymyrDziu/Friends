//
//  FriendDetailView.swift
//  Friends
//
//  Created by Volodymyr Dziubenko on 24.02.2026.
//

import SwiftUI
import SwiftData

struct FriendDetailView: View {
    @Bindable var friend: Friend
    let isNew: Bool
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Movie.title) private var movies: [Movie]
    
    init(friend: Friend, isNew: Bool) {
        self.friend = friend
        self.isNew = isNew
    }
    
    var body: some View {
        Form {
            TextField("Name", text: $friend.name)
                .autocorrectionDisabled()
            
            Picker("favoriteMovie", selection: $friend.favoritMovie){
                Text("None")
                    .tag(nil as Movie?)
                
                ForEach(movies){ movie in
                    Text(movie.title)
                        .tag(movie)
                }
            }
        }
        .navigationTitle(isNew ? "New friend" : "Friend")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if isNew {
                ToolbarItem( placement: .confirmationAction) {
                    Button("Save"){
                        dismiss()
                    }
                }
                ToolbarItem( placement: .cancellationAction) {
                    Button("Cancel"){
                        modelContext.delete(friend)
                        dismiss()
                    }
                }
            }
        }  
    }
}

#Preview {
    NavigationStack {
        FriendDetailView(friend: SampleData.shared.friend, isNew: true)
    }
    .modelContainer(SampleData.shared.modelContainer)
}
