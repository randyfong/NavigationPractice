//
//  NavigationPractice.swift
//  NavigationPractice
//
//  Created by Randy Fong on 4/1/25.
//

import Foundation
import SwiftUI

enum LighthouseNavigationPath: String, CaseIterable {
        case launch
        case searchingForLocation

        case introBeaconFound
        case loadManifest
        case loadMedia
        case prepareBeacons

        case readyToStartTour
        case startTour

        case touring
        case takeSurvey
        case endTour
    
    static let searchForLocationPath: [LighthouseNavigationPath]  = [.launch, .searchingForLocation]
    static let prepareLocationPath: [LighthouseNavigationPath]  = [.introBeaconFound, loadManifest, loadMedia, .prepareBeacons]
    static let readyToBeginTourPath: [LighthouseNavigationPath]  = [.readyToStartTour, .startTour]
    static let conductTourPath: [LighthouseNavigationPath]  = [.touring, .takeSurvey, .endTour]
}

enum HomeTabSelection: String, CaseIterable {
    case location
    case media
    case tour

    var title: String {
        switch self {
        case .location:
            return "Location"
        case .media:
            return "Media"
        case .tour:
            return "Tour"
        }
    }

    // tab icon
    var icon: String {
        switch self {
        case .location:
            return "location.fill"
        case .media:
            return "photo.fill.on.rectangle.fill"
        case .tour:
            return "map.fill"
        }
    }
}

struct Home: View {
    @State private var selectedTab: HomeTabSelection = .location
    @State var navigationPath: [LighthouseNavigationPath]
    
    var locationView: LocationView
    
    var body: some View {
        TabView(selection: $selectedTab) {
            locationView
                .tabItem {
                    Label(HomeTabSelection.location.title, systemImage: HomeTabSelection.location.icon)
                }
                .tag(HomeTabSelection.location)

            MediaView(message: "Loading media for your location...")
                .tabItem {
                    Label(HomeTabSelection.media.title, systemImage: HomeTabSelection.media.icon)
                }
                .tag(HomeTabSelection.media)
            TourView(message: "Start you tour...")
                .tabItem {
                    Label(HomeTabSelection.tour.title, systemImage: HomeTabSelection.tour.icon)
                }
                .tag(HomeTabSelection.tour)
        }
    }
}

//struct HomeView: View {
//    let message: String
//    var body: some View {
//        VStack {
//            Text(message)
//        }
//    }
//}

#Preview("Navigation") {
    Home(navigationPath: [LighthouseNavigationPath](),
         locationView:
                LocationView(
                    locationModel:  LocationViewModel(
                        locationDetected: false,
                        message: "Searching for your location...")
                )
         )
}

//struct TabView: View {
//    @State private var selectedTab = 0
//
//    var body: some View {
//        TabView(selection: $selectedTab) {
//            LocationView()
//                .tabItem {
//                    Label("Location", systemImage: "location.fill")
//                }
//                .tag(0)
//
//            MediaView()
//                .tabItem {
//                    Label("Media", systemImage: "photo.fill.on.rectangle.fill")
//                }
//                .tag(1)
//
//            TourView()
//                .tabItem {
//                    Label("Tour", systemImage: "map.fill")
//                }
//                .tag(2)
//        }
//    }
//}

struct LocationView: View {
    @State var locationModel: LocationViewModel
    var body: some View {
        VStack {
            Text(locationModel.message)
            Button("Intro Location ") {
                if locationModel.isLocationIntroDetected(0) {
                    locationModel.message = "Intro Location Found!"
                } else {
                    locationModel.message = "Intro Location Not Found!"
                }
            }
            .padding()
            Button("Intro Location Not Found ") {
                if locationModel.isLocationIntroDetected(99) {
                    locationModel.message = "Intro Location Found!"
                } else {
                    locationModel.message = "Intro Location Not Found!"
                }
            }
        }
    }
}

struct MediaView: View {
    @State var message: String
    var body: some View {
        Text(message)
    }
}

struct TourView: View {
    @State var message: String
    var body: some View {
        Text(message)
    }
}

// --------------------

@Observable
class LocationViewModel {
    var locationDetected: Bool
    var message: String
    
    init(locationDetected: Bool, message: String) {
        self.locationDetected = locationDetected
        self.message          = message
    }
    
    func setLocationDetected(_ locationDetected: Bool) {
        self.locationDetected = locationDetected
    }
    func isLocationDetected() -> Bool {
        return locationDetected
    }
    
    func isLocationIntroDetected(_ location: Int) -> Bool {
        guard location == 0 else { return false }
        return true
    }
    
}

/*
NavigationStack(path: $navigationPath) {
    VStack {
        NavigationLink("Search", value: LighthouseNavigationPath.searchingForLocation)
            .padding()
        Button("Prepare") {
            navigationPath.append(.prepareBeacons)
        }
        .padding()
        Button("Ready") {
            navigationPath.append(.readyToStartTour)
        }
        .padding()
        Button("Begin Tour") {
            navigationPath.append(.startTour)
        }
        .padding()
    }
    .navigationDestination(for: LighthouseNavigationPath.self) { path in
        switch path {
        case .searchingForLocation:
            HomeView(message: "Searching for Location")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.blue)
        case .prepareBeacons:
            HomeView(message: "Prepare Beacons")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.green)
        case .readyToStartTour:
            HomeView(message: "Ready To Start Tour")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.pink)
        case .startTour:
            HomeView(message: "Start Tour")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.orange)
        default:
            Text("Default")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.red)
        }
    }
}

*/
