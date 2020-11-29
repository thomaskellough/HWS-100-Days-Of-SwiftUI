//
//  AstronautView.swift
//  Moonshot
//
//  Created by Thomas Kellough on 9/8/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    
    let astronaut: Astronaut
    let missions: [Mission]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    Group {
                        Image(self.astronaut.id)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width)
                            .accessibility(hidden: true)
                        
                        Text(self.astronaut.description)
                            .padding()
                            .layoutPriority(1)
                        
                    }
                    .accessibilityElement(children: .combine)
                    .accessibility(label: Text(self.astronaut.description))
                    
                    Group {
                        Text("Missions flown")
                            .padding()
                            .font(.headline)
                        ForEach(self.missions) { mission in
                            Text(mission.displayName)
                                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 20))
                        }
                    }
                    .accessibilityElement(children: .combine)
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
    
    init(astronaut: Astronaut, missions: [Mission]) {
        self.astronaut = astronaut
        
        var astronautMissions: [Mission] = []
        
        for mission in missions {
            for crew in mission.crew {
                if astronaut.name.lowercased().contains(crew.name.lowercased()) {
                    astronautMissions.append(mission)
                    break
                }
            }
        }
        
        self.missions = astronautMissions
    }
}

struct AstronautView_Previews: PreviewProvider {
    
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[0], missions: missions)
    }
}
