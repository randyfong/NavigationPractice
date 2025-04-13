//
//  LocationSearchView.swift
//  NavigationPractice
//
//  Created by Randy Fong on 4/1/25.
//

import SwiftUI
import MapKit

// --------- Environment Data
extension EnvironmentValues {
    @Entry var navigate = LocationNavigationAction { _ in }
}





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


// --------- Navigation Action
struct LocationNavigationAction {
    typealias LocationAction = (LocationRoute) -> Void
    let action: LocationAction
    func callAsFunction(_ route: LocationRoute) -> Void {
        action(route)
    }
}

struct SearchForLocationNavigationAction {
    typealias SearchForLocationAction  = (LocationRoute) -> Void
    let action: SearchForLocationAction
    func callAsFunction(_ route: LocationRoute) -> Void {
        action(route)
    }
}

struct LocationFoundNavigationAction {
    typealias LocationFoundAction  = (LocationRoute) -> Void
    let action: LocationFoundAction
    func callAsFunction(_ route: LocationRoute) -> Void {
        action(route)
    }
}

struct LocationSearchHomeView: View {
    @Environment(\.navigate) private var navigate
    let locationSearchAction: LocationSearchAction
    var body: some View {
        VStack {
            Text("Location Search")
                .font(.largeTitle)
                .padding(.top, 10)
                .padding(.bottom, 50)
            VStack(spacing: 50) {
                Button(action: {
                    locationSearchAction.searchFound()
                    navigate(.searchForLocation)
                }) {
                    VStack {
                        Image(systemName: "wifi")
                            .font(.system(size: 60))
                            .foregroundColor(.blue)
                        Text("Local")
                            .font(.title)
                            .padding(.top, 25)
                    }
                }
            }
        }
    }
}

#Preview("Launch") {
    @Previewable @Environment(\.navigate) var navigate
    @Previewable @State var routes: [LocationRoute] = []
    let address = Address(street: "123 Main St", city: "Anytown", state: "CA", postalCode: "12345")
    let locationSearchAction: LocationSearchAction = .init(
        cancelSearch: { },
        searchFound: { } )
    let searchForLocationAction: SearchForLocationAction = .init(
        cancelSearch: { },
        searchFound: { } )
    let locationFoundAction: LocationFoundAction = .init(
        cancelSearch: { },
        saveLocation: { } )
    
    NavigationStack(path: $routes) {
        LocationSearchHomeView(locationSearchAction: locationSearchAction)
            .navigationDestination(for: LocationRoute.self) { route in
                switch route {
                case .locationSearch:
                    LocationSearchHomeView(locationSearchAction: locationSearchAction)
                case .searchForLocation:
                    SearchForLocationView(searchForLocationAction: searchForLocationAction)
                case .locationFound(let address):
                    LocationFoundView(address: address,
                                      locationFoundAction: locationFoundAction)
                default:
                    Text("Default")
                }
            }
        Spacer()
    }
    .environment(\.navigate, LocationNavigationAction { route in
        switch route {
        case .locationSearch:
            print("locationSearch")
            routes.removeAll()
        case .locationFound(address: address):
            print("locationFound")
            routes.append(route)
        default:
            print("add route \(route)")
            routes.append(route)
        }
    })
}


class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation?

    override init() {
        super.init()
        locationManager.delegate = self
    }

    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
        locationManager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
    }
}
