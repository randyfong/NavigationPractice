//
//  MainView.swift
//  NavigationPractice
//
//  Created by Randy Fong on 4/21/25.
//

import SwiftUI

extension EnvironmentValues {
    @Entry var navigateLocation = LocationNavigationAction { _ in }
}

struct MainView: View {
    @Environment(Router.self) private var router
    var body: some View {
        @Bindable var router = router
        Button(action: {
//            locationSearchAction.searchLocation()
            print("Button Pressed")
//            navigateLocation(.searchForLocation)
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
//            locationSearchAction.mapLocation()
//            navigateLocation(.locationMapView)
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

#Preview("Main") {
    
    @Previewable @Environment(\.navigateLocation) var navigateLocation
    @Previewable @State var router: Router = Router()
    let locationSearchAction: LocationSearchAction = .init(
        searchLocation: { },
        mapLocation: { } )
    let searchForLocationAction: SearchForLocationAction = .init(
        cancelSearch: { },
        searchFound: { } )
    let locationFoundAction: LocationFoundAction = .init(
        cancelSearch: { },
        saveLocation: { } )
    
    let loadMediaRoute = LoadMediaRoute.begin
    
    TabView {
        NavigationStack(path: $router.locationRoutes) {
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
                        }
                    }
                Spacer()
            }
        }
        .environment(\.navigateLocation, LocationNavigationAction { route in
            switch route {
            case .locationSearch:
                router.locationRoutes.removeAll()
            case .searchForLocation:
                router.locationRoutes = [route]
            case .locationFound(_):
                router.locationRoutes = [route]
            default:
                router.locationRoutes.append(route)
            }
        })
        .tabItem {
            Label("Search", systemImage: "magnifyingglass")
        }
        
//-----------------------------
        NavigationStack(path: $router.loadMediaRoutes) {
            VStack {
                LocationMediaView(loadMediaRoute: loadMediaRoute)
                Spacer()
            }
        }
        .tabItem {
            Label("Media", systemImage: "arrow.up.right.video")
        }
//--------------------------------
        
        NavigationStack(path: $router.tourRoutes) {
            VStack {
                TourSiteView()
                    .navigationDestination(for: TourRoute.self) { tourRoute in
                        switch tourRoute {
                        case .overview:
                            TourSiteView()
                        case .conductTour(location: let location):
                            TourItemView(location: location)
                        }
                    }
                Spacer()
            }
        }
        .environment(\.navigateTour, TourNavigationAction { route in
            switch route {
            case .overview:
                router.tourRoutes.removeAll()
            case .conductTour(_):
                router.tourRoutes = [route]
            }
        })
        .tabItem {
            Label("Tour", systemImage: "figure.walk.motion")
        }
    }
        
}

