//
//  TourNavigationAction.swift
//  NavigationPractice
//
//  Created by Randy Fong on 4/20/25.
//

import Foundation

struct TourNavigationAction {
    typealias TourAction = (TourRoute) -> Void
    let action: TourAction
    func callAsFunction(_ route: TourRoute) -> Void {
        action(route)
    }
}
