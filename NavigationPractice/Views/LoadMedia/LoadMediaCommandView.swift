//
//  LoadMediaCommandView.swift
//  NavigationPractice
//
//  Created by Randy Fong on 4/13/25.
//

import SwiftUI

// --------- Environment Data
extension EnvironmentValues {
    @Entry var navigateLoadMedia = LoadMediaNavigationAction { _ in }
}

struct LocationMediaView: View {
    @Environment(\.navigateLoadMedia) private var navigate
//    let loadMediaAction: LocationMediaAction
    let address = Address(street: "123 Main St", city: "Anytown", state: "CA", postalCode: "12345")

    var body: some View {
        VStack {
            Text("Message: Select to load")
                .font(.body)
                .padding(.top, 10)
                .padding(.bottom, 50)
            VStack(spacing: 50) {
                Button(action: {
                }) {
                    VStack {
                        Text("Load")
                            .font(.body)
                            .padding(.top, 25)
                    }
                }
            }
        }
    }
}

/*

#Preview("Launch") {
    @Previewable @Environment(\.navigate) var navigate
    @Previewable @State var routes: [LoadMediaRoute] = []
//    let address = Address(street: "123 Main St", city: "Anytown", state: "CA", postalCode: "12345")
//    let locationSearchAction: LocationSearchAction = .init(
//        searchLocation: { },
//        mapLocation: { } )
//    let searchForLocationAction: SearchForLocationAction = .init(
//        cancelSearch: { },
//        searchFound: { } )
//    let locationFoundAction: LocationFoundAction = .init(
//        cancelSearch: { },
//        saveLocation: { } )
    
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
    .environment(\.navigate, LocationNavigationAction { route in
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


#Preview {
    LoadMediaCommandView()
}
*/
