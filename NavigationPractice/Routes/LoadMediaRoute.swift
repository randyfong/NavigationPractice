//
//  LoadMediaRoute.swift
//  NavigationPractice
//
//  Created by Randy Fong on 4/14/25.
//

import Foundation

enum LoadMediaRoute: Hashable {
    case begin
    case load
    case cancel
    case reload
    case successfulCompletion
    case error(String)
}
