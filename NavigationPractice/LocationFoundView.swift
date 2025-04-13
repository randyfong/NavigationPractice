//
//  LocationFoundView.swift
//  NavigationPractice
//
//  Created by Randy Fong on 4/13/25.
//

import SwiftUI

struct LocationFoundView: View {
    @Environment(\.navigate) private var navigate
    let address: Address
    
//    let startTour: () -> Void
//    let loadMedia: () -> Void
//    let reLoadMedia: () -> Void
    
    let locationFoundAction: LocationFoundAction
    
    var body: some View {
        VStack(spacing: 20) {
            Text(address.formattedAddress)
                .font(.title)
                .padding(.top, 50)

            Image("")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 150)

            HStack(spacing: 50) {
                Button(action: {
                    self.locationFoundAction.cancelSearch()
                    navigate(.locationSearch)
                }) {
                    Text("Cancel")
                        .font(.title)
                }

                Button(action: {
                    self.locationFoundAction.saveLocation()
                    navigate(.locationSearch)
                }) {
                    Text("Save")
                        .font(.title)
                }
            }

            Spacer()
        }
    }
}
