//
//  LoadMediaNavigationAction.swift
//  NavigationPractice
//
//  Created by Randy Fong on 4/14/25.
//

import Foundation

struct LoadMediaNavigationAction {
    typealias LoadMediaAction = (LoadMediaRoute) -> Void
    let action: LoadMediaAction
    func callAsFunction(_ route: LoadMediaRoute) -> Void {
        action(route)
    }
}
