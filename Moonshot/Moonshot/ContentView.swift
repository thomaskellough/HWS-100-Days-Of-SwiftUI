//
//  ContentView.swift
//  Moonshot
//
//  Created by Thomas Kellough on 9/6/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var toggleLaunchCrew = false
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        Text(self.toggleLaunchCrew ? mission.formattedLaunchDate : mission.crewName)
                    }
                    .accessibilityElement(children: .combine)
                    .accessibility(label: Text("\(self.toggleLaunchCrew ? "Mission: \(mission.displayName). Launch date: \(mission.formattedLaunchDate)" : "Mission: \(mission.displayName). Crew members: \(mission.crewName)")"))
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing:
                Button("Launch/Crew") {
                    self.toggleLaunchCrew.toggle()
                }
                .accessibility(label: Text("Filter by launch or crew. Currently filtered with \(self.toggleLaunchCrew ? "launch date" : "crew members")"))
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
