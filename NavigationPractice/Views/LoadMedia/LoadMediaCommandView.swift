//
//  LoadMediaCommandView.swift
//  NavigationPractice
//
//  Created by Randy Fong on 4/13/25.
//

import SwiftUI

struct LocationMediaView: View {
    @Environment(\.navigateLoadMedia) private var navigate
    @State var loadMediaRoute: LoadMediaRoute
    
//    let loadMediaAction: LocationMediaAction
    let address = Address(street: "123 Main St", city: "Anytown", state: "CA", postalCode: "12345")

    var body: some View {
        VStack {
//            Text("Message: Select to load")
//                .font(.body)
//                .padding(.top, 10)
//                .padding(.bottom, 50)
            switch loadMediaRoute {
            case .begin:
                Text("Press button to begin")
            case .load:
                Text("Loading....")
                    .foregroundColor(.blue)
                    .padding()
            case .cancel:
                Text("Load Cancelled")
                    .foregroundColor(.red)
                    .padding()
            case .reload:
                Text("Loading....")
                    .foregroundColor(.green)
                    .padding()
            case .successfulCompletion:
                Text("Media Loaded")
                    .foregroundColor(.green)
                    .padding()
            case .error(let message):
                Text("Error: \(message)")
                    .foregroundColor(.red)
                    .padding()
            }

            VStack(spacing: 50) {
                Button(action: {
                }) {
                    VStack {
                        /*
                         enum LoadMediaRoute: Hashable {
                             case beginning
                             case load
                             case cancel
                             case reload
                             case successfulCompletion
                             case error(String)
                         }
                         */
                        switch loadMediaRoute {
                        case .begin:
                            Button("Load Media") {
                                loadMediaRoute = .load
                            }
                            .padding(5)
                        case .load:
                            Button("Cancel") {
                                loadMediaRoute = .begin
                            }
                            .padding(5)
                            Button("Complete") {
                                loadMediaRoute = .successfulCompletion
                            }
                            .padding(5)
                            Button("Force Error") {
                                loadMediaRoute = .error("Something went wrong")
                            }
                        case .cancel:
                            Button("Load Media") {
                                loadMediaRoute = .begin
                            }
                        case .reload:
                            Button("Cancel") {
                                loadMediaRoute = .begin
                            }
                            .padding(5)
                            Button("Complete") {
                                loadMediaRoute = .successfulCompletion
                            }
                        case .successfulCompletion:
                            Button("Delete") {
                                loadMediaRoute = .begin
                            }
                            .padding(5)
                            Button("Reload") {
                                loadMediaRoute = .load
                            }
                            .padding(5)
                            Button("Back to Begin") {
                                loadMediaRoute = .begin
                            }
                        case .error(_):
                            Button("Attempt Reload") {
                                loadMediaRoute = .load
                            }
                            .padding(5)
                            Button("Begin") {
                                loadMediaRoute = .begin
                            }

                        }
                    }
                }
            }
            .padding(20)
        }

    }
}

#Preview("Launch") {
    @Previewable @Environment(\.navigateLoadMedia) var navigate
    @Previewable @State var loadMediaRoute: LoadMediaRoute = .begin
    LocationMediaView(loadMediaRoute: loadMediaRoute)
}

#Preview("Successful Load") {
    @Previewable @Environment(\.navigateLoadMedia) var navigate
    @Previewable @State var loadMediaRoute: LoadMediaRoute = .successfulCompletion
    LocationMediaView(loadMediaRoute: loadMediaRoute)
}

#Preview("Error") {
    @Previewable @Environment(\.navigateLoadMedia) var navigate
    @Previewable @State var loadMediaRoute: LoadMediaRoute = .error("DB Error")
    LocationMediaView(loadMediaRoute: loadMediaRoute)
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
