//
//  GameViewModel.swift
//  quizzy
//
//  Description:
//  View Model for StatsView (handles user interactions)
//
//  Created by Kristen Chen on 12/3/20.
//

import Foundation
import SwiftUI

class GameViewModel : ObservableObject {
    
    @Published var gameInPlay: Bool = false // becomes true once user picks theme and number of questions
    @Published var isOver: Bool = false // becomes true after user finishes all the questions
    
    @Published var theme: String = "General Knowledge" // theme of questions
    @Published var qNumber: Int = 0 // current question number
    @Published var numberQs: Double = 10 // number of questions in the game
    
    var game: Game? // Game model
    @Published var question: String = "" // current question
    @Published var answers: [String] = [] // current answer choices
    var correctAnswerIndex: Int = 0 // current correctAnswerIndex
    
    @Published var showingAnswer: Bool = false // if true, shows answer. if false, shows answer choices for user to guess.
    
    @Published var numIncorrect: Int = 0 // number of incorrect guesses
    
    /* Initializes a new game. */
    init() {
        restart()
    }
    
    /* Resets model properties to restart game. */
    func restart() {
        self.gameInPlay = false
        self.isOver = false
        self.qNumber = 0
        self.numIncorrect = 0
        self.showingAnswer = false
    }
    
    /* Starts the game */
    func start() {
        let vmGroup = DispatchGroup()
        vmGroup.enter()
        DispatchQueue.main.async {
            self.game = Game(theme: self.theme, numberQs: Int(self.numberQs), vmGroup: vmGroup)
        }
        vmGroup.notify(queue: .main) {
            self.question = self.getQuestion()
            self.answers = self.getAnswers()
            self.gameInPlay = true
        }
    }
    
    /* Generates next question. */
    func next() {
        if (qNumber + 1 == Int(numberQs)) {
            end()
            return
        }
        
        qNumber += 1
        self.question = getQuestion()
        self.answers = getAnswers()
        self.showingAnswer = false
    }
    
    /* Sets theme. */
    func pickTheme(theme: String) {
        self.theme = theme
    }
    
    /* Ends the game */
    func end() {
        self.game!.saveData(numIncorrect: self.numIncorrect)
        self.gameInPlay = false
        self.isOver = true
    }
    
    /* Retrieves the current question. */
    func getQuestion() -> String {
        let q = game?.questionSet?.results[qNumber].question ?? "No question"
        return cleanString(string: q)
    }
    
    /* Retrieves the current answer choices. */
    func getAnswers() -> [String] {
        var arr = game?.questionSet?.results[qNumber].incorrect_answers ?? ["No", "incorrect", "answers"]
        self.correctAnswerIndex = Int.random(in: 0...3)
        arr.insert(game?.questionSet?.results[qNumber].correct_answer ?? "No correct answer", at: correctAnswerIndex)
        
        var fin_arr = [String]()
        for item in (0..<arr.count) {
            fin_arr.append(cleanString(string: arr[item]))
        }
        return fin_arr
    }
    
    /* Responds to user making a guess. */
    func makeGuess(index: Int) {
        if (index != correctAnswerIndex) {
            self.numIncorrect += 1
        }
        self.showingAnswer = true
    }
    
    /* Cleans up string from weird unicode issues. */
    func cleanString(string: String) -> String {
        return string
            .replacingOccurrences(of: "&quot;", with: "\u{22}")
            .replacingOccurrences(of: "&ldquo;", with: "\u{22}")
            .replacingOccurrences(of: "&rdquo;", with: "\u{22}")
            .replacingOccurrences(of: "&#039;", with: "\u{27}")
            .replacingOccurrences(of: "&rsquo;", with: "\u{27}")
            .replacingOccurrences(of: "&shy;", with: "\u{00AD}")
            .replacingOccurrences(of: "&hellip;", with: "\u{2026}")
            .replacingOccurrences(of: "&amp", with: "\u{0026}")
            .replacingOccurrences(of: "&lrm;", with: "")
            .replacingOccurrences(of: "&auml;", with: "\u{00e4}")
            .replacingOccurrences(of: "&ouml;", with: "\u{00F6}")
            .replacingOccurrences(of: "&oacute;", with: "\u{00F3}")
            .replacingOccurrences(of: "&eacute;", with: "\u{00C9}")
            .replacingOccurrences(of: "&Eacute;", with: "\u{00E9}")
            .replacingOccurrences(of: "&;", with: "\u{0026}")
            .replacingOccurrences(of: "&ndash;", with: "\u{2013}")
    }
}
