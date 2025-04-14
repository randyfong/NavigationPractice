//
//  LocationMapView.swift
//  NavigationPractice
//
//  Created by Randy Fong on 4/13/25.
//

import Foundation
import CoreLocation
import SwiftUI
import MapKit

struct LocationMapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), // Default to San Francisco
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )

    @State private var userLocation: CLLocationCoordinate2D?
    @StateObject private var locationManager = LocationManager()

    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(.follow))
            .onAppear {
                locationManager.requestLocation()
            }
            .onChange(of: locationManager.location) { newLocation in
                if let location = newLocation {
                    userLocation = location.coordinate
                    region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
                }
            }
    }
}
