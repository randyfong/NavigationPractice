//
//  ViewActions.swift
//  NavigationPractice
//
//  Created by Randy Fong on 4/13/25.
//

import Foundation

typealias VoidClosure = () -> Void

struct LocationSearchAction: Hashable {
    let id = UUID()
    let searchLocation: VoidClosure
    let mapLocation: VoidClosure
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: LocationSearchAction, rhs: LocationSearchAction) -> Bool {
         return lhs.id == rhs.id
    }
}

struct SearchForLocationAction: Hashable {
    let id = UUID()
    let cancelSearch: VoidClosure
    let searchFound: VoidClosure
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: SearchForLocationAction, rhs: SearchForLocationAction) -> Bool {
        return lhs.id == rhs.id
    }
}

struct LocationFoundAction: Hashable {
    let id = UUID()
    let cancelSearch: VoidClosure
    let saveLocation: VoidClosure
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: LocationFoundAction, rhs: LocationFoundAction) -> Bool {
        return lhs.id == rhs.id
    }
}
