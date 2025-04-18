//
//  TourSiteView.swift
//  NavigationPractice
//
//  Created by Randy Fong on 4/18/25.
//

import SwiftUI

enum TourSite {
    case overview
    case conductTour
}

struct TourSiteView: View {
    @State var locations: [String] = ["Entrance", "Living Room", "Kitchen", "Bedroom"]
    var body: some View {
        List(locations, id: \.self) { location in
            NavigationLink(location, value: location)
        }
    }
}

struct TourItemView: View {
    let item: String
    var body: some View {
        Text(item)
    }
}

#Preview {
    NavigationStack {
        TourSiteView()
            .navigationDestination(for: String.self) { location in
                TourItemView(item: location)
            }
    }
}
