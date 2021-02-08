//
//  StatsViewModel.swift
//  quizzy
//
//  Description:
//  View Model for StatsView (handles user interactions)
//
//  Created by Kristen Chen on 12/4/20.
//

import Foundation
import SwiftUI
import Resolver

class StatsViewModel : ObservableObject {
    
    @Published var games: [CompletedGame] = [CompletedGame]() // user's completed games
    @Published var accuracy: Double = 0 // user's accuracy
    @Published var barData: [(String, Double)] = [(String, Double)]() // user's bar chart data
    @Published var pieData: [Double] = [Double]() // user's pie chart data
    
    @Published var barFilter: String = "All" // which category the user wants to view in the bar chart
    @Published var pieFilter: String = "General Knowledge" // which category the user wants to view in the pie chart

    @Published var gameRepository: FirestoreGameRepository = Resolver.resolve() // the repository
    
    init() {
        refresh()
    }
    
    /* Refreshes the stats data. */
    func refresh() {
        gameRepository.loadData()
        self.games = gameRepository.savedGames
        self.accuracy = getAccuracy()
        self.barData = getBarData()
        self.pieData = getPieData()
    }
    
    /* Calculates the user's accuracy. */
    func getAccuracy() -> Double {
        if (games.count == 0) {
            return 0
        }
        var correctCount = 0
        var questionsCount = 0
        for game in games {
            correctCount += (game.numQs - game.numIncorrect)
            questionsCount += game.numQs
        }
        print(correctCount)
        print(questionsCount)
        return 100 * (Double(correctCount) / Double(questionsCount))
    }
    
    /* Retrieves the user's bar chart data. */
    func getBarData() -> [(String, Double)] {
        var data = [(String, Double)]()
        for game in games {
            if (self.barFilter == "All") {
                data.append((game.category, 100 * Double(game.numQs - game.numIncorrect) / Double(game.numQs)))
            } else {
                if (game.category == self.barFilter) {
                    data.append((game.category, 100 * Double(game.numQs - game.numIncorrect) / Double(game.numQs)))
                }
            }
        }
        return data
    }
    
    /* Retrieves the user's pie chart data. */
    func getPieData() -> [Double] {
            var correctIncorrect = [0, 0]
            var gamesCount = 0
            
            for game in games {
                if (game.category == self.pieFilter) {
                    correctIncorrect[0] += game.numQs - game.numIncorrect
                    correctIncorrect[1] += game.numIncorrect
                    gamesCount += game.numQs
                }
            }
            
            var r = [0.0, 0.0]
            for num in correctIncorrect {
                r.append(100 * Double(num) / Double(gamesCount))
            }
            return r
    }
    
    /* Responds to user filtering data for bar chart. */
    func filterBarData(theme: String) {
        self.barFilter = theme
        self.barData = getBarData()
    }
    
    /* Responds to user filtering data for pie chart. */
    func filterPieData(theme: String) {
        self.pieFilter = theme
        self.pieData = getPieData()
    }
}
