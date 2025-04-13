//
//  LocationRoute.swift
//  NavigationPractice
//
//  Created by Randy Fong on 4/13/25.
//


enum LocationRoute: Hashable {
    case locationSearch
    case searchForLocation
    case locationFound(address: Address)
    case locationMapView(address: Address)
}