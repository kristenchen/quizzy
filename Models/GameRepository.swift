//
//  GameRepository.swift
//  quizzy
//
//  Description:
//  Handles saving and retrieving games from the database.
//
//  Created by Kristen Chen on 12/2/20.
//

import Foundation
import SwiftUI

import Combine
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import Resolver

class BaseGameRepository {
    @Published var savedGames: [CompletedGame] = [CompletedGame]()
}

protocol GameRepository: BaseGameRepository {
    func addGame(_ game: CompletedGame)
}

class FirestoreGameRepository: BaseGameRepository, GameRepository, ObservableObject {
    
    @Injected var sessionStore: SessionStore
    var gamesPath: String = "games"
    
    var db = Firestore.firestore()
    
    override init() {
        super.init()
        self.savedGames = [CompletedGame]()
    }

    /* Adds a game to the Firestore database. */
    func addGame(_ game: CompletedGame) {
        do {
            var userGame = game
            sessionStore.configureUserAuth()
            userGame.userID = sessionStore.session?.email ?? "none"
            let _ = try db.collection("games").addDocument(from: userGame)
        } catch {
              print("There was an error while trying to save a game \(error.localizedDescription).")
        }
        loadData()
    }
    
    /* Retrieves games from the Firestore database. */
    func loadData() {
        sessionStore.configureUserAuth()
        db.collection("games")
            .whereField("userID", isEqualTo: sessionStore.session?.email ?? "")
            .order(by: "createdTime")
            .addSnapshotListener { (querySnapshot, error) in // (2)
                if let querySnapshot = querySnapshot {
                    self.savedGames = querySnapshot.documents.compactMap { document -> CompletedGame? in
                        try? document.data(as: CompletedGame.self)
                    }
                }
            }
    }
}

