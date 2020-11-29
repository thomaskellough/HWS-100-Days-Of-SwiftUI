//
//  MapKit.swift
//  Milestone 13-15 NameToFace
//
//  Created by Thomas Kellough on 11/28/20.
//

import MapKit
import SwiftUI

struct MapView: UIViewRepresentable {
    var centerCoordinate: CLLocationCoordinate2D

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        print("Updating view")
        if view.annotations.count == 0 {
            print("Adding annotation...")
            let annotation = MKPointAnnotation()
            annotation.coordinate = centerCoordinate
            view.addAnnotation(annotation)
            
        }
    }
    
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        print(mapView.centerCoordinate)
    }

}

// MARK : Coordinator Methods
extension MapView {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let identifier = "Placemark"
            
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
                annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            } else {
                annotationView?.annotation = annotation
            }
            
            return annotationView
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            parent.centerCoordinate = mapView.centerCoordinate
        }

        init(_ parent: MapView) {
            self.parent = parent
        }
    }
}
