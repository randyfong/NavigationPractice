//
//  SearchForLocationView.swift
//  NavigationPractice
//
//  Created by Randy Fong on 4/13/25.
//

import SwiftUI

struct SearchForLocationView: View {
    @Environment(\.navigateLocation) private var navigate
    @State private var isPulsating = false
    
    let address = Address(street: "123 Main St", city: "Anytown", state: "CA", postalCode: "12345")
    
    let searchForLocationAction: SearchForLocationAction

    var body: some View {
        VStack {
            Text("Searching")
                .font(.largeTitle)
                .padding(.top, 10)
                .padding(.bottom, 50)

            Image(systemName: "wifi")
                .font(.system(size: 60))
                .foregroundColor(.blue)
                .scaleEffect(isPulsating ? 1.5 : 1.0)
                .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true), value: isPulsating)

            Button(action: {
                self.searchForLocationAction.cancelSearch()
                navigate(.locationSearch)
            }) {
                Text("Cancel")
                    .font(.title)
            }
            .padding(.top, 20)
            Button(action: {
                self.searchForLocationAction.searchFound()
                navigate(.locationFound(address: address))
            }) {
                Text("Location Found")
                    .font(.title)
            }
            .padding(.top, 20)
            Spacer()
        }
        .toolbar(.hidden)
        .onAppear {
            isPulsating = true
        }
    }
}
