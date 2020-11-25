//
//  DetailFriendView.swift
//  Milestone 10-12 Friendface
//
//  Created by Thomas Kellough on 11/24/20.
//

import SwiftUI

struct DetailFriendView: View {
    
    let friend: Friend
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "building.fill")
                Text(friend.company)
                Spacer()
            }
            HStack {
                Image(systemName: "house.fill")
                Text(friend.address)
                Spacer()
            }
            HStack {
                Image(systemName: "envelope.fill")
                Text(friend.email)
                Spacer()
            }
            Text("Age: \(friend.age)")
                .padding(.bottom)
            Text("About:\n\(friend.about)")
            
            Spacer()
        }
        .padding()
        .navigationBarTitle(friend.name)
    }
}

struct DetailFriendView_Previews: PreviewProvider {
    static var previews: some View {
        let testFriend = Friend(id: UUID(), isActive: true, name: "John Smith", age: 20, company: "Apple", email: "johnsmith@apple.com", address: "123 Main St", about: "About John Smith", registered: Date(), tags: [], friends: [])
        DetailFriendView(friend: testFriend)
    }
}
