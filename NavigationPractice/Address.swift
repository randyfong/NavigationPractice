//
//  Address.swift
//  NavigationPractice
//
//  Created by Randy Fong on 4/13/25.
//

struct Address: Codable, Hashable {
    var street: String
    var city: String
    var state: String
    var postalCode: String
    var country: String?

    init(street: String, city: String, state: String, postalCode: String, country: String? = nil) {
        self.street = street
        self.city = city
        self.state = state
        self.postalCode = postalCode
        self.country = country
    }

    var formattedAddress: String {
        var result = "\(street)\n\(city), \(state) \(postalCode)"
        if let country = country {
            result += "\n\(country)"
        }
        return result
    }
}
