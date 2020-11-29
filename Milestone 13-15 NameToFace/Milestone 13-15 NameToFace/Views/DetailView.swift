//
//  DetailView.swift
//  Milestone 13-15 NameToFace
//
//  Created by Thomas Kellough on 11/28/20.
//

import MapKit
import SwiftUI

struct DetailView: View {
    @State private var segmentedIndex = 0
    var person: Person?
    
    var body: some View {
        VStack {
            Picker(selection: $segmentedIndex, label: Text("Photo or Map View")) {
                Text("Photo").tag(0)
                Text("Map").tag(1)
            }.pickerStyle(SegmentedPickerStyle())
            
            if segmentedIndex == 0 {
                if person?.image != nil {
                    person?.image!
                        .resizable()
                        .scaledToFit()
                }
            } else if segmentedIndex == 1 {
                MapView(centerCoordinate: (person?.location)!)
            }
            
            Spacer()
        }
        .navigationBarTitle(person!.unwrappedName)
    }
}
