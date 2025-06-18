//
//  ScoresView 2.swift
//  CompassGuesser
//
//  Created by Alisha Qureshi on 6/18/25.
//


import SwiftUI

struct ScoresView: View {
    @ObservedObject var store = ScoreStore.shared

    var body: some View {
        NavigationView {
            List {
                ForEach(store.scores.indices, id: \.self) { index in
                    let score = store.scores[index]
                    VStack(alignment: .leading) {
                        Text("Target: \(Int(score.target))°, Your Guess: \(Int(score.actual))°")
                        Text("Accuracy: \(Int(score.accuracy))%")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                .onDelete(perform: store.delete)
            }
            .navigationTitle("Past Scores")
            .toolbar {
                Button("Clear All") {
                    store.clear()
                }
            }
        }
    }
}
