//
//  ContentView.swift
//  Milestone 10-12 Friendface
//
//  Created by Thomas Kellough on 11/22/20.
//

import SwiftUI

struct ContentView: View {
    
    let networking = Networking()
    @State private var friends: [Friend] = []
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(friends, id: \.id) { friend in
                        NavigationLink(destination: DetailFriendView(friend: friend)) {
                            HStack {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Image(systemName: "person.crop.circle.fill")
                                        Text(friend.name)
                                            .font(.title2)
                                            .foregroundColor(.blue)
                                    }
                                    HStack {
                                        Image(systemName: "globe")
                                        Text(friend.company)
                                            .font(.body)
                                    }
                                }
                                
                                Spacer()
                                
                                friend.isActive ? Image(systemName: "checkmark.rectangle.fill").colorMultiply(.green) : Image(systemName: "xmark.rectangle.fill").colorMultiply(.red)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Friendface")
            .onAppear {
                getFriends()
            }
        }
    }
    
    func getFriends() {
        networking.makeGetRequest() { completion in
            switch completion {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    let decoded = try decoder.decode([Friend].self, from: data)
                    print("Success!")
                    self.friends = decoded.sorted {
                        $0.name < $1.name
                    }
                } catch let error {
                    print("Error! \n\(error.localizedDescription)")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
