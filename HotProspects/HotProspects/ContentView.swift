//
//  ContentView.swift
//  HotProspects
//
//  Created by Thomas Kellough on 11/29/20.
//

import SwiftUI

enum NetworkError: Error {
    case badURL, requestFailed, unknown
}

struct ContentView: View {
    @State private var selectedTab = "Tab 1 View"

    var body: some View {
        TabView(selection: $selectedTab) {
            Text("Hello, World!")
                .onAppear {
                    self.fetchData(from: "https://www.apple.com") { result in
                        switch result {
                        case .success(let str):
                            print(str)
                        case .failure(let error):
                            switch error {
                            case .badURL:
                                print("Bad url")
                            case .requestFailed:
                                print("Request failed")
                            case .unknown:
                                print("Unknown")
                            }
                        }
                    }
                }
                .onTapGesture {
                    self.selectedTab = "Tab 2 View"
                }
                .tabItem {
                    Image(systemName: "star")
                    Text("Tab One")
                }
                .tag("Tab 1 View")
        }
    }
    
    func fetchData(from urlString: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    let string = String(data: data, encoding: .utf8)
                    completion(.success(string!))
                } else if error != nil {
                    completion(.failure(.requestFailed))
                } else {
                    completion(.failure(.unknown))
                }
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

