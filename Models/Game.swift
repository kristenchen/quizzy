//
//  GameModel.swift
//  quizzy
//
//  Description:
//  Game Model. Retrieves questions from API and saves back to database.
//
//  Created by Kristen Chen on 12/1/20.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON
import Combine
import Resolver

class Game: Identifiable {
    @Published var gameRepository: FirestoreGameRepository = Resolver.resolve()
    
    var category: String
    var numberQs: Int
    var questionSet: QuestionSet?
    let group2 = DispatchGroup()
    
    init(theme: String, numberQs: Int, vmGroup: DispatchGroup) {
        self.category = theme
        self.numberQs = numberQs
        group2.enter()
        DispatchQueue.main.async {
            self.fetchData(theme: theme, numberQs: numberQs)
        }
        group2.notify(queue: .main) {
            vmGroup.leave()
        }
    }
    
    /* Fetches the JSON for questions and sets questionSet. */
    func fetchData(theme: String, numberQs: Int) {
        let group = DispatchGroup()
        let api = pickAPI(theme: theme, numberQs: numberQs)

        group.enter()
        DispatchQueue.main.async {
            AF.request(api).responseJSON { response in
                self.questionSet = try! JSONDecoder().decode(QuestionSet.self, from: response.data!)
                group.leave()
            }
        }
        group.notify(queue: .main) {
            self.group2.leave()
        }
    }
    
    /* Returns the API */
    func pickAPI(theme: String, numberQs: Int) -> String {
        if (theme == "General Knowledge") {
            return "https://opentdb.com/api.php?amount=\(numberQs)&category=9&type=multiple"
        } else if (theme == "Science & Nature") {
            return "https://opentdb.com/api.php?amount=\(numberQs)&category=17&type=multiple"
        } else if (theme == "History" ){
            return "https://opentdb.com/api.php?amount=\(numberQs)&category=23&type=multiple"
        } else {
            return "https://opentdb.com/api.php?amount=\(numberQs)&category=27&type=multiple"
        }
    }
    
    /* After a game is over, saves game information to database. */
    func saveData(numIncorrect: Int) {
        gameRepository.addGame(
            CompletedGame(category: questionSet!.results[0].category, numQs: numberQs, numIncorrect: numIncorrect)
        )
    }
}

