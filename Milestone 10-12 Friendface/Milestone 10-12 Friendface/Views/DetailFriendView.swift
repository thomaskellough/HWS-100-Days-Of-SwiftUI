//
//  DetailFriendView.swift
//  Milestone 10-12 Friendface
//
//  Created by Thomas Kellough on 11/24/20.
//

import SwiftUI

struct DetailFriendView: View {
    
    let friend: CDFriend
    @FetchRequest(entity: CDFriend.entity(), sortDescriptors: []) var cdFriends: FetchedResults<CDFriend>
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "building.fill").resizable()
                    .frame(width: 28, height: 28)
                Text(friend.unwrappedCompany)
                Spacer()
            }
            HStack {
                Image(systemName: "house.fill").resizable()
                    .frame(width: 28, height: 28)
                Text(friend.cityAndState)
                Spacer()
            }
            HStack {
                Image(systemName: "envelope.fill").resizable()
                    .frame(width: 28, height: 28)
                Text(friend.unwrappedEmail)
                Spacer()
            }
            Text("Age: \(friend.age)")
            Text("Total friends: \(friend.numberOfFriends)")
                .padding(.bottom)
            Text("About:\n\(friend.unwrappedAbout)")
            
            VStack(alignment: .leading) {
                Text("Friends")
                    .font(.title3)
                ForEach(friend.friendArray, id: \.self) { friendOfFriend in
                    NavigationLink(
                        destination: DetailFriendView(friend: cdFriends.first(where: {$0.name == friendOfFriend})!),
                        label: {
                            Text(friendOfFriend)
                                .foregroundColor(.blue)
                        })
                }
            }
            Spacer()
        }
        .padding()
        .navigationBarTitle(friend.unwrappedName)
    }
}

struct DetailFriendView_Previews: PreviewProvider {
    static var previews: some View {
        let testFriend = CDFriend()
        
        DetailFriendView(friend: testFriend)
    }
}
