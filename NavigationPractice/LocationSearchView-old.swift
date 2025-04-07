//
//  LocationSearchView-old.swift
//  NavigationPractice
//
//  Created by Randy Fong on 4/3/25.
//

/*
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
    case searchForLocationsView
    case locationsFoundView
}
struct LocationSearchHomeView: View {
    @State var locationSearchModel: LocationSearchModel = .init(locationSearchView: .locationSearchHomeView)
    @State var path: [LocationSearchViews] = [LocationSearchViews]()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Text("Lighthouse")
                    .font(.largeTitle)
                NavigationLink("Search For Locations", value: LocationSearchViews.searchForLocationsView)
                .padding()
                NavigationLink("Locations Found", value: LocationSearchViews.locationsFoundView)
            }

        .navigationDestination(for: LocationSearchViews.self) { locationSearchView in
            switch locationSearchView {
            case .locationSearchHomeView:
                EmptyView()
            case .searchForLocationsView:
                SearchForLocationsView(stopSearchForLocations: { self.path.removeAll() } )
            case .locationsFoundView:
                LocationsFoundView(
                    startTour: { },
                    loadMedia: { },
                    reLoadMedia: { },
                    searchForLocations: { self.path = [LocationSearchViews.searchForLocationsView] },
                    locationHome: { self.path.removeAll() }
                    )
            }
        }
        }
        .onChange(of: locationSearchModel.locationSearchViews) {
            print("View changed to \(locationSearchModel.locationSearchViews)")
            self.path.append(locationSearchModel.locationSearchViews)
        }
    }
    
    private func showSearchForLocationsView() -> some View {
        path = [.searchForLocationsView]
        return self
    }
}

struct SearchForLocationsView: View {
    let stopSearchForLocations: () -> Void
    var body: some View {
        Text("Searching for Locations")
            .padding()
        Button("Stop Search") {
            stopSearchForLocations()
        }
    }
}

struct LocationsFoundView: View {
    let startTour: () -> Void
    let loadMedia: () -> Void
    let reLoadMedia: () -> Void
    
    let searchForLocations: () -> Void
    let locationHome: () -> Void
    var body: some View {
        Text("Locations Found")
        Button("Search Locations") {
            searchForLocations()
        }
        .padding()
        Button("Home") {
            locationHome()
        }
    }
}

#Preview("Launch") {
    LocationSearchHomeView()
}

*/
