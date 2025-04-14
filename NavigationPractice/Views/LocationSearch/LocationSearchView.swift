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
    @Entry var navigateLocation = LocationNavigationAction { _ in }
}

struct LocationSearchView: View {
    @Environment(\.navigateLocation) private var navigate
    let locationSearchAction: LocationSearchAction
    let address = Address(street: "123 Main St", city: "Anytown", state: "CA", postalCode: "12345")

    var body: some View {
        VStack {
            Text("Location Search")
                .font(.largeTitle)
                .padding(.top, 10)
                .padding(.bottom, 50)
            VStack(spacing: 50) {
                Button(action: {
                    locationSearchAction.searchLocation()
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
                Button(action: {
                    locationSearchAction.mapLocation()
                    navigate(.locationMapView)
                }) {
                    VStack {
                        Image(systemName: "map")
                            .font(.system(size: 60))
                            .foregroundColor(.blue)
                        Text("Map")
                            .font(.title)
                            .padding(.top, 25)
                    }
                }
            }
        }
    }
}

#Preview("Launch") {
    @Previewable @Environment(\.navigateLocation) var navigate
    @Previewable @State var routes: [LocationRoute] = []
    let address = Address(street: "123 Main St", city: "Anytown", state: "CA", postalCode: "12345")
    let locationSearchAction: LocationSearchAction = .init(
        searchLocation: { },
        mapLocation: { } )
    let searchForLocationAction: SearchForLocationAction = .init(
        cancelSearch: { },
        searchFound: { } )
    let locationFoundAction: LocationFoundAction = .init(
        cancelSearch: { },
        saveLocation: { } )
    
    NavigationStack(path: $routes) {
        VStack {
            LocationSearchView(locationSearchAction: locationSearchAction)
                .navigationDestination(for: LocationRoute.self) { route in
                    switch route {
                    case .locationSearch:
                        LocationSearchView(locationSearchAction: locationSearchAction)
                    case .searchForLocation:
                        SearchForLocationView(searchForLocationAction: searchForLocationAction)
                    case .locationFound(let address):
                        LocationFoundView(address: address,
                                          locationFoundAction: locationFoundAction)
                    case .locationMapView:
                        LocationMapView()
                    default:
                        Text("Default")
                    }
                }
            Spacer()
        }
    }
    .environment(\.navigateLocation, LocationNavigationAction { route in
        switch route {
        case .locationSearch:
            routes.removeAll()
        case .searchForLocation:
            routes = [route]
        case .locationFound(address: address):
            routes = [route]
        default:
            routes.append(route)
        }
    })
}
