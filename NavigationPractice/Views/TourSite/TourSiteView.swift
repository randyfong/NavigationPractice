//
//  TourSiteView.swift
//  NavigationPractice
//
//  Created by Randy Fong on 4/18/25.
//

import SwiftUI

extension EnvironmentValues {
    @Entry var navigateTour = TourNavigationAction { _ in }
}

struct TourSiteView: View {
    @Environment(\.navigateTour) private var navigate
    @State var locations: [Location] =
    [.init(name: "Entrance"),
     .init(name: "Living Room"),
     .init(name: "Kitchen"),
     .init(name: "Bedroom")]
    
    var body: some View {
        List(locations, id: \.self) { location in
            VStack {
                Button(location.name) {
                    navigate(.conductTour(location: location))
                }
            }
        }
    }
}

struct TourItemView: View {
    let location: Location
    var body: some View {
        Text("Name: \(location.name)")
    }
}

#Preview("Tour Site") {
    @Previewable @Environment(\.navigateTour) var navigate
    @Previewable @State var routes: [TourRoute] = []
    
    NavigationStack(path: $routes) {
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
            routes.removeAll()
        case .conductTour(_):
            routes = [route]
        }
    })
}
