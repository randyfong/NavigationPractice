//
//  LocationSearchView.swift
//  NavigationPractice
//
//  Created by Randy Fong on 4/1/25.
//

import SwiftUI

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

enum LocationSearchViews: CaseIterable  {
    case locationSearchHomeView
    case searchForLocalLocationView
    case locationFoundView
    case locationMapView
}
struct LocationSearchHomeView: View {
    @State var locationSearchModel: LocationSearchModel = .init(locationSearchView: .locationSearchHomeView)
    @State var path: [LocationSearchViews] = [LocationSearchViews]()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                 Text("Location Search")
                     .font(.largeTitle)
                     .padding(.top, 10)
                     .padding(.bottom, 50)
                 VStack(spacing: 50) {
                     Button(action: {
                         self.path.append(.searchForLocalLocationView)
                     }) {
                         VStack {
                             Image(systemName: "wifi")
                                 .font(.system(size: 60))
                                 .foregroundColor(.blue)
                             Text("Local")
                                 .font(.title)
                         }
                     }

                     Button(action: {
                         self.path.append(.locationMapView)
                     }) {
                         VStack {
                             Image(systemName: "map.fill")
                                 .font(.system(size: 60))
                                 .foregroundColor(.red)
                             Text("Map")
                                 .font(.title)
                         }
                     }
                     Spacer()
                 }
             }
        .navigationDestination(for: LocationSearchViews.self) { locationSearchView in
            switch locationSearchView {
            case .locationSearchHomeView:
                EmptyView()
            case .searchForLocalLocationView:
                SearchForLocationsView(
                    cancelLocalSearch: {
                        path.removeAll()
                    },
                    localSearchFound: {
                    path.append(.locationFoundView)
                    }
                )
            case .locationFoundView:
                LocationsFoundView(
                    address:  Address(street: "123 Main St", city: "Anytown", state: "CA", postalCode: "91234", country: nil),
                    startTour: { },
                    loadMedia: { },
                    reLoadMedia: { },
                    cancelLocation: { self.path.removeAll() },
                    saveLocation: { self.path.removeAll() }
                    )
            case .locationMapView:
                LocationMapView()
            }
        }
        }
        .onChange(of: locationSearchModel.locationSearchViews) {
            print("View changed to \(locationSearchModel.locationSearchViews)")
            self.path.append(locationSearchModel.locationSearchViews)
        }
    }
    
    private func showSearchForLocationsView() -> some View {
        path = [.searchForLocalLocationView]
        return self
    }
}

struct SearchForLocationsView: View {
    @State private var isPulsating = false
    let cancelLocalSearch: () -> Void
    let localSearchFound: () -> Void

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
                self.cancelLocalSearch()
            }) {
                Text("Cancel")
                    .font(.title)
            }
            .padding(.top, 20)
            Button(action: {
                self.localSearchFound()
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

struct Address: Codable, Hashable {
    var street: String
    var city: String
    var state: String
    var postalCode: String
    var country: String? // Country is optional

    // Optional: Add an initializer for convenience
    init(street: String, city: String, state: String, postalCode: String, country: String? = nil) {
        self.street = street
        self.city = city
        self.state = state
        self.postalCode = postalCode
        self.country = country
    }

    // Optional: Add a formatted address string for display
    var formattedAddress: String {
        var result = "\(street)\n\(city), \(state) \(postalCode)"
        if let country = country {
            result += "\n\(country)"
        }
        return result
    }
}

struct LocationsFoundView: View {
    let address: Address
    
    let startTour: () -> Void
    let loadMedia: () -> Void
    let reLoadMedia: () -> Void
    
    let cancelLocation: () -> Void
    let saveLocation: () -> Void
    
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
                    self.cancelLocation()
                }) {
                    Text("Cancel")
                        .font(.title)
                }

                Button(action: {
                    self.saveLocation()
                }) {
                    Text("Save")
                        .font(.title)
                }
            }

            Spacer()
        }
    }
}

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

//struct CurrentLocationMapView_Previews: PreviewProvider {
//    static var previews: some View {
//        LocationMapView()
//    }
//}

#Preview("Launch") {
    LocationSearchHomeView()
}

