//
//  LoadMediaRoute.swift
//  NavigationPractice
//
//  Created by Randy Fong on 4/14/25.
//

import Foundation

enum LoadMediaRoute: Hashable {
    case beginning
    case load
    case cancel
    case successfulCompletion
    case errorMessage(String)
}
