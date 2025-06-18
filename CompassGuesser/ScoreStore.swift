//
//  ScoreStore.swift
//  CompassGuesser
//
//  Created by Alisha Qureshi on 6/18/25.
//

import Foundation

struct Score: Codable {
    let target: Double
    let actual: Double
    let accuracy: Double
}

class ScoreStore: ObservableObject {
    static let shared = ScoreStore()

    @Published var scores: [Score] = []

    private let key = "PastScores"

    private init() {
        load()
    }

    func addScore(target: Double, actual: Double, accuracy: Double) {
        let new = Score(target: target, actual: actual, accuracy: accuracy)
        scores.insert(new, at: 0)
        save()
    }

    func delete(at offsets: IndexSet) {
        scores.remove(atOffsets: offsets)
        save()
    }

    func clear() {
        scores.removeAll()
        save()
    }

    private func save() {
        if let data = try? JSONEncoder().encode(scores) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    private func load() {
        if let data = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode([Score].self, from: data) {
            scores = decoded
        }
    }
}
