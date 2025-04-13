//
//  LocationNavigationAction.swift
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
