//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Thomas Kellough on 12/18/20.
//

import SwiftUI

struct ResortView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @State private var selectedFacility: String?
    let resort: Resort
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Image(decorative: resort.id)
                    .resizable()
                    .scaledToFit()
                
                HStack {
                    if sizeClass == .compact {
                        Spacer()
                        VStack { ResortDetailsView(resort: resort) }
                        Spacer().frame(height: 0)
                        VStack { SkiDetailsView(resort: resort) }
                        Spacer()
                    } else {
                        ResortDetailsView(resort: resort)
                        Spacer()
                        SkiDetailsView(resort: resort)
                    }
                }
                .font(.headline)
                .foregroundColor(.secondary)
                .padding(.top)
                
                Group {
                    Text(resort.description)
                        .padding(.vertical)
                    
                    Text("Facilities")
                        .font(.headline)
                    
                    HStack {
                        ForEach(resort.facilities, id: \.self) { facility in
                            Facility.icon(for: facility)
                                .font(.title)
                                .onTapGesture {
                                    self.selectedFacility = facility
                                }
                        }
                    }
                    .padding(.vertical)
                }
                .padding(.horizontal)
            }
        }
        .navigationBarTitle(Text("\(resort.name), \(resort.country)"), displayMode: .inline)
        .alert(item: $selectedFacility) { facility in
            Facility.alert(for: facility)
        }
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        ResortView(resort: Resort.example)
    }
}
