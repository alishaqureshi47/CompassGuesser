//
//  PlayView.swift
//  CompassGuesser
//
//  Created by Alisha Qureshi on 6/18/25.
//

import Foundation
import SwiftUI
import CoreLocation

struct PlayView: View {
    @StateObject private var compass = CompassManager()
    @State private var targetDirection: Double = Double.random(in: 0..<360)
    @State private var locked = false
    @State private var score: Int? = nil
    @State private var lockedHeading = 0.0


    var body: some View {
        VStack(spacing: 30) {
            Text("Point to: \(directionName(for: targetDirection)) \(targetDirection)")
                .font(.title)
                .bold()

            ZStack {
                if !locked {
                    // While guessing: empty dial and fixed white bar
                    Circle()
                        .stroke(Color.gray.opacity(0.3), lineWidth: 2)
                        .frame(width: 300, height: 300)
                    
                    GuessMarker() // fixed at top
                } else {
                    ZStack {
                        // Show compass markers, rotating with live heading
                        ForEach(Marker.markers(), id: \.self) { marker in
                            CompassMarkerView(marker: marker, compassDegress: compass.heading)
                        }
                        .rotationEffect(Angle(degrees: -compass.heading))
                        
                        // Show the guessed direction bar, now rotated
                        // Keep the bar pointing to guessed direction relative to rotating compass
                        GuessMarker()
                            .rotationEffect(Angle(degrees: lockedHeading - compass.heading))

                    }
                    .frame(width: 300, height: 300)
                }
            }

            

            if locked, let score = score {
                Text("Your Accuracy: \(score)%")
                    .font(.title2)
                    .foregroundColor(score > 80 ? .green : .orange)
            }

            Button(locked ? "Play Again" : "Lock Guess") {
                if locked {
                    // Reset for new round
                    locked = false
                    score = nil
                    targetDirection = Double.random(in: 0..<360)
                } else {
                    lockedHeading = compass.heading   // <- ADD THIS LINE
                    locked = true
                    let accuracy = calculateAccuracy(target: targetDirection, actual: compass.heading)
                    score = Int(accuracy)
                    ScoreStore.shared.addScore(target: targetDirection, actual: compass.heading, accuracy: accuracy)
                }
            }
            .padding()
            .background(Color.blue.opacity(0.8))
            .foregroundColor(.white)
            .cornerRadius(12)
            .animation(.easeInOut, value: locked)
        }
        .padding()

    }

    func directionName(for degrees: Double) -> String {
        let directions = ["North", "North-East", "East", "South-East", "South", "South-West", "West", "North-West"]
        let index = Int((degrees + 22.5) / 45.0) % 8
        return directions[index]
    }

    func calculateAccuracy(target: Double, actual: Double) -> Double {
        let diff = abs((target - actual).truncatingRemainder(dividingBy: 360))
        let wrappedDiff = diff > 180 ? 360 - diff : diff
        let accuracy = 100 - (wrappedDiff / 180 * 100)
        return accuracy
    }
}
