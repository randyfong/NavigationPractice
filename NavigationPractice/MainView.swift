//
//  MainView.swift
//  NavigationPractice
//
//  Created by Randy Fong on 4/21/25.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview("Main") {
    @Previewable @State var locationRoutes: LocationRoute? = .locationSearch
    @Previewable @State var loadMediaRoutes: LoadMediaRoute?
    @Previewable @State var tourRoutes: TourRoute?
    
    NavigationStack {
        MainView()
    }
}
