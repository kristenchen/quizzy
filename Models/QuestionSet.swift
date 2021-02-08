//
//  QuestionSet.swift
//  quizzy
//
//  Description:
//  Turns the JSON questions into the QuestionSet Codable struct.
//
//  Created by Kristen Chen on 12/2/20.
//

import Foundation
import SwiftUI

struct QuestionSet : Codable {
    var response_code: Int
    var results: [Question]
    
    struct Question: Codable {
        var category: String
        var type: String
        var difficulty: String
        var question: String
        var correct_answer: String
        var incorrect_answers: [String]
    }
}
