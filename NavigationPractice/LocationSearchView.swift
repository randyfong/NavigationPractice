//
//  LocationSearchView.swift
//  NavigationPractice
//
//  Created by Randy Fong on 4/1/25.
//

import SwiftUI
import MapKit

// --------- Struct Data

struct Address: Codable, Hashable {
    var street: String
    var city: String
    var state: String
    var postalCode: String
    var country: String?

    init(street: String, city: String, state: String, postalCode: String, country: String? = nil) {
        self.street = street
        self.city = city
        self.state = state
        self.postalCode = postalCode
        self.country = country
    }

    var formattedAddress: String {
        var result = "\(street)\n\(city), \(state) \(postalCode)"
        if let country = country {
            result += "\n\(country)"
        }
        return result
    }
}

// --------- Environment Data
extension EnvironmentValues {
    @Entry var navigate = LocationNavigationAction { _ in }
}

// --------- Views
enum LocationSearchViews: CaseIterable  {
    case locationSearchHomeView
    case searchForLocalLocationView
    case locationFoundView
    case locationMapView
}

struct SearchForLocationView: View {
    @Environment(\.navigate) private var navigate
    @State private var isPulsating = false
    
    let address = Address(street: "123 Main St", city: "Anytown", state: "CA", postalCode: "12345")
    
    let searchForLocationAction: SearchForLocationAction

    var body: some View {
        VStack {
            Text("Searching")
                .font(.largeTitle)
                .padding(.top, 10)
                .padding(.bottom, 50)

            Image(systemName: "wifi")
                .font(.system(size: 60))
                .foregroundColor(.blue)
                .scaleEffect(isPulsating ? 1.5 : 1.0)
                .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true), value: isPulsating)

            Button(action: {
                self.searchForLocationAction.cancelSearch()
                navigate(.locationSearch)
            }) {
                Text("Cancel")
                    .font(.title)
            }
            .padding(.top, 20)
            Button(action: {
                self.searchForLocationAction.searchFound()
                navigate(.locationFound(address: address))
            }) {
                Text("Location Found")
                    .font(.title)
            }
            .padding(.top, 20)
            Spacer()
        }
        .onAppear {
            isPulsating = true
        }
    }
}



struct LocationFoundView: View {
    @Environment(\.navigate) private var navigate
    let address: Address
    
//    let startTour: () -> Void
//    let loadMedia: () -> Void
//    let reLoadMedia: () -> Void
    
    let locationFoundAction: LocationFoundAction
    
    var body: some View {
        VStack(spacing: 20) {
            Text(address.formattedAddress)
                .font(.title)
                .padding(.top, 50)

            Image("")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 150)

            HStack(spacing: 50) {
                Button(action: {
                    self.locationFoundAction.cancelSearch()
                    navigate(.locationSearch)
                }) {
                    Text("Cancel")
                        .font(.title)
                }

                Button(action: {
                    self.locationFoundAction.saveLocation()
                    navigate(.locationSearch)
                }) {
                    Text("Save")
                        .font(.title)
                }
            }

            Spacer()
        }
    }
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


// --------- View Actions
typealias VoidClosure = () -> Void

struct LocationSearchAction: Hashable {
    let id = UUID()
    let cancelSearch: VoidClosure
    let searchFound: VoidClosure
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: LocationSearchAction, rhs: LocationSearchAction) -> Bool {
         return lhs.id == rhs.id
    }
}

struct SearchForLocationAction: Hashable {
    let id = UUID()
    let cancelSearch: VoidClosure
    let searchFound: VoidClosure
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: SearchForLocationAction, rhs: SearchForLocationAction) -> Bool {
        return lhs.id == rhs.id
    }
}

struct LocationFoundAction: Hashable {
    let id = UUID()
    let cancelSearch: VoidClosure
    let saveLocation: VoidClosure
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: LocationFoundAction, rhs: LocationFoundAction) -> Bool {
        return lhs.id == rhs.id
    }
}

enum LocationRoute: Hashable {
    case locationSearch
    case searchForLocation
    case locationFound(address: Address)
    case locationMapView(address: Address)
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

// --------- Models

@Observable
class LocationSearchModel {
    var locationSearchViews: LocationSearchViews
    var timerCount = 0
    init(locationSearchView: LocationSearchViews) {
        self.locationSearchViews = locationSearchView
//        runEveryFiveSeconds()
    }
    
    func runEveryFiveSeconds() {
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
            if self.timerCount == 10 {
                timer.invalidate() // invalidate the timer
            } else {
                self.timerCount += 1
                let randomView = LocationSearchViews.allCases.randomElement() ?? .locationSearchHomeView
//                self.locationSearchViews = randomView
                if randomView != .locationSearchHomeView {
                    self.locationSearchViews = randomView
                }
            }
        }
    }
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
