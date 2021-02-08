//
//  User.swift
//  quizzy
//
//  Description:
//  Random constants used throughout the views.
//
//  Created by Kristen Chen on 11/29/20.
//

import Foundation

class User : ObservableObject {
    
    var userID: String
    var email: String
    
    init(uid: String, email: String) {
        self.userID = uid
        self.email = email
    }
    
}
