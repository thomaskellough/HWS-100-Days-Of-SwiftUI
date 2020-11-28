//
//  UnlockedView.swift
//  BucketList
//
//  Created by Thomas Kellough on 11/28/20.
//

import MapKit
import SwiftUI

struct UnlockedView: View {
    
    @Binding var centerCoordinate: CLLocationCoordinate2D
    @Binding var selectedPlace: MKPointAnnotation?
    @Binding var showingplaceDetails: Bool
    @Binding var locations: [CodableMKPointAnnotation]
    @Binding var showingEditScreen: Bool
    
    var body: some View {
        ZStack {
            MapView(centerCoordinate: $centerCoordinate, selectedPlace: $selectedPlace, showingPlaceDetails: $showingplaceDetails, annotations: locations)
            Circle()
                .fill(Color.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        let newLocation = CodableMKPointAnnotation()
                        newLocation.title = "Example location"
                        newLocation.coordinate = self.centerCoordinate
                        self.locations.append(newLocation)
                        self.showingEditScreen = true
                    }) {
                        Image(systemName: "plus")
                            .padding()
                            .background(Color.black.opacity(0.75))
                            .foregroundColor(.white)
                            .font(.title)
                            .clipShape(Circle())
                            .padding(.trailing)
                    }
                }
            }
        }
    }
}
