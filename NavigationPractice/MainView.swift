//
//  MainView.swift
//  NavigationPractice
//
//  Created by Randy Fong on 4/21/25.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview("Main") {
    @Previewable @State var locationRoutes: LocationRoute? = .locationSearch
    @Previewable @State var loadMediaRoutes: LoadMediaRoute?
    @Previewable @State var tourRoutes: TourRoute?
    
    let locationSearchAction: LocationSearchAction = .init(
        searchLocation: { },
        mapLocation: { } )
    let searchForLocationAction: SearchForLocationAction = .init(
        cancelSearch: { },
        searchFound: { } )
    let locationFoundAction: LocationFoundAction = .init(
        cancelSearch: { },
        saveLocation: { } )
    
    
    NavigationStack {
        MainView()
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
        .navigationDestination(for: LoadMediaRoute.self) { route in
            switch route {
            default:
                LocationMediaView(loadMediaRoute: route)
            }
        }
        .navigationDestination(for: TourRoute.self) { route in
            switch route {
            case .overview:
                TourSiteView()
            case .conductTour(location: let location):
                TourItemView(location: location)
            }
        }
    }
}
