//
//  FriendListView.swift
//  Friends
//
//  Created by Volodymyr Dziubenko on 23.02.2026.
//

import SwiftUI
import SwiftData

struct FriendListView: View {
    @Query(sort: \Friend.name) private var friends: [Friend]
    @Environment(\.modelContext) private var modelContext
    
    @State private var newFriend: Friend?
   
    
    var body: some View {
        NavigationSplitView {
            Group {
                if !friends.isEmpty {
                    List {
                        ForEach(friends) { friend in
                            NavigationLink (friend.name){
                                FriendDetailView(friend: friend, isNew: true)
                                    .navigationTitle("Friend")
                                    .navigationBarTitleDisplayMode(.inline)
                            }
                        }
                        .onDelete(perform: deleteFriend(indexes: ))
                    }
                } else {
                    ContentUnavailableView("Add friends", systemImage: "person.and.person")
                }
            }
            .navigationTitle("Friends")
            .toolbar {
                ToolbarItem {
                    Button("Add", systemImage: "plus", action: addFriend)
                }
                ToolbarItem {
                    EditButton()
                }
            }
            .sheet(item: $newFriend) { friend in
                NavigationStack {
                    FriendDetailView(friend: friend, isNew: true)
                }
                .interactiveDismissDisabled()
            }
            
        }detail: {
            Text("Select on friend") 
                .navigationTitle("friends")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func addFriend(){
        let newFriend = Friend(name: "")
        modelContext.insert(newFriend)
        self.newFriend = newFriend
    }
    
    private func deleteFriend(indexes: IndexSet){
        for index in indexes {
            modelContext.delete(friends[index])
        }
    }
}

#Preview {
    FriendListView()
        .modelContainer(SampleData.shared.modelContainer)
}
