//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Thomas Kellough on 12/17/20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var favorites = Favorites()
    @State private var filterSelection = -1
    @State private var sortSelection = 0
    @State private var filteredResorts: [Resort] = Bundle.main.decode("resorts.json")
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Section(header: Text("Filter")) {
                    Picker(selection: $filterSelection, label: Text("Filter")) {
                        Text("All").tag(0)
                        Text("U.S. Only").tag(1)
                        Text("Large").tag(2)
                        Text("$$$").tag(3)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding([.leading, .trailing])
                .onChange(of: filterSelection) { _ in
                    self.filterResorts()
                }
                
                Section(header: Text("Sort")) {
                    Picker(selection: $sortSelection, label: Text("Sort")) {
                        Text("Default").tag(0)
                        Text("Alphabetical").tag(1)
                        Text("Country").tag(2)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding([.leading, .trailing])
                .onChange(of: sortSelection) { _ in
                    self.sortResorts()
                }
                
                List(filteredResorts) { resort in
                    NavigationLink(destination: ResortView(resort: resort)) {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 5)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        .layoutPriority(1)
                        
                        if self.favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibility(label: Text("This is a favorite resort"))
                                .foregroundColor(.red)
                        }
                    }
                }
                .navigationBarTitle("Resorts")
                .phoneOnlyStackNavigationView()
            }
            
            WelcomeView()
        }
        .environmentObject(favorites)
    }
    
    func sortResorts() {
        var sorted: [Resort] = []
        switch sortSelection {
        case 1:
            sorted = filteredResorts.sorted { $0.name < $1.name }
        case 2:
            sorted = filteredResorts.sorted { $0.country < $1.country }
        default:
            sorted = resorts
            
        }
        self.filteredResorts = sorted
    }
    
    func filterResorts() {
        switch filterSelection {
        case 1:
            self.filteredResorts = resorts.filter { $0.country.lowercased() == "united states" }
        case 2:
            self.filteredResorts = resorts.filter { $0.size == 3 }
        case 3:
            self.filteredResorts = resorts.filter { $0.price == 3 }
        default:
            self.filteredResorts = resorts
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
