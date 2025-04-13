//
//  NavigationAction.swift
//  NavigationPractice
//
//  Created by Randy Fong on 4/13/25.
//


struct LocationNavigationAction {
    typealias LocationAction = (LocationRoute) -> Void
    let action: LocationAction
    func callAsFunction(_ route: LocationRoute) -> Void {
        action(route)
    }
}

struct SearchForLocationNavigationAction {
    typealias SearchForLocationAction  = (LocationRoute) -> Void
    let action: SearchForLocationAction
    func callAsFunction(_ route: LocationRoute) -> Void {
        action(route)
    }
}

struct LocationFoundNavigationAction {
    typealias LocationFoundAction  = (LocationRoute) -> Void
    let action: LocationFoundAction
    func callAsFunction(_ route: LocationRoute) -> Void {
        action(route)
    }
}
