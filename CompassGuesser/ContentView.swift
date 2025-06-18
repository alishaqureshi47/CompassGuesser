//
//  ContentView.swift
//  CompassGuesser
//
//  Created by Alisha Qureshi on 6/17/25.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    var body: some View {
        TabView {
            PlayView()
                .tabItem {
                    Label("Play", systemImage: "location.north.line")
                }

            ScoresView()
                .tabItem {
                    Label("Scores", systemImage: "list.bullet")
                }
        }
    }
}

