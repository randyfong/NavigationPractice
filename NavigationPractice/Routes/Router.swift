//
//  Router.swift
//  NavigationPractice
//
//  Created by Randy Fong on 4/25/25.
//

import Foundation

@Observable
class Router: Hashable {
    var locationRoutes: [LocationRoute] = []
    var loadMediaRoutes: [LoadMediaRoute] = []
    var tourRoutes: [TourRoute] = []
    
    init(locationRoutes: [LocationRoute] = [], loadMediaRoutes: [LoadMediaRoute] = [], tourRoutes: [TourRoute] = []) {
        self.locationRoutes     = locationRoutes
        self.loadMediaRoutes    = loadMediaRoutes
        self.tourRoutes         = tourRoutes
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(locationRoutes)
        hasher.combine(loadMediaRoutes)
        hasher.combine(tourRoutes)
    }
    
    static func ==(lhs: Router, rhs: Router) -> Bool {
        return lhs.locationRoutes == rhs.locationRoutes &&
            lhs.loadMediaRoutes == rhs.loadMediaRoutes &&
            lhs.tourRoutes == rhs.tourRoutes
    }
}
