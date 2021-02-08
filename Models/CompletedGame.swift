//
//  CompletedGame.swift
//  quizzy
//
//  Description:
//  Game information that needs to be saved to database.
//
//  Created by Kristen Chen on 12/4/20.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct CompletedGame : Identifiable, Codable {
    
    @DocumentID var id: String? // id for the game
    var category: String // game's category
    var numQs: Int // number of questions in the game
    var numIncorrect: Int // number of questions the user got incorrect
    @ServerTimestamp var createdTime: Timestamp? // the time of completion of the game
    var userID: String? // the user's email
    
}
