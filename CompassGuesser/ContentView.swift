//
//  ContentView.swift
//  CompassGuesser
//
//  Created by Alisha Qureshi on 6/17/25.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @StateObject var compass = CompassManager()

    var body: some View {
        VStack(spacing: 30) {
            Capsule()
                .frame(width: 5, height: 50)

            ZStack {
                ForEach(Marker.markers(), id: \.self) { marker in
                    CompassMarkerView(marker: marker,
                                      compassDegress: compass.heading)
                }
            }
            .frame(width: 300, height: 300)
            .rotationEffect(Angle(degrees: -compass.heading))
        }
        .padding()
    }
}
