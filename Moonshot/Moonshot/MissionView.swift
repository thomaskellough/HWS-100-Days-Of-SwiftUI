//
//  MissionView.swift
//  Moonshot
//
//  Created by Thomas Kellough on 9/6/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import SwiftUI

struct MissionView: View {
    
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let mission: Mission
    let astronauts: [CrewMember]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Group {
                        Image(self.mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: geometry.size.width * 0.7)
                            .padding(.top)
                            .accessibility(hidden: true)
                        
                        Text("Launched: \(self.mission.formattedLaunchDate)")
                            .font(.headline)
                            .foregroundColor(.purple)
                        
                        Text(self.mission.description)
                            .padding()
                    }
                    .accessibilityElement(children: .combine)
                    .accessibility(label: Text("Launched on \(self.mission.formattedLaunchDate). \(self.mission.description)"))
                    
                    ForEach(self.astronauts, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut, missions: self.missions)) {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 83)
                                    .clipShape(Circle())
                                    .overlay(Capsule().stroke(crewMember.role.lowercased() == "commander" ? Color.red : Color.primary, lineWidth: 2))
                                
                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)
                                    Text(crewMember.role)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                .accessibilityElement(children: .combine)
                                .accessibility(label: Text("\(crewMember.astronaut.name) as \(crewMember.role)"))
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
    
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission
        
        var matches = [CrewMember]()
        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }
        
        self.astronauts = matches
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
    }
}

struct CrewMember {
    let role: String
    let astronaut: Astronaut
}
