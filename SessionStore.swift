//
//  SessionStore.swift
//  quizzy
//
//  Description:
//  Handles user authentication (log in, log out, sign up)
//
//  Created by Kristen Chen on 11/29/20.
//

import Foundation
import SwiftUI
import Firebase
import Combine

class SessionStore: ObservableObject {
    
    @Published var didChange = PassthroughSubject<SessionStore, Never>()
    @Published var session: User? { didSet { self.didChange.send(self) }}
    var handle: AuthStateDidChangeListenerHandle?
    
    func configureUserAuth() {
        // Monitor authentication changes using firebase
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                // If we have a user, create a new user model
                print("Got user: \(user)")
                self.session = User(
                    uid: user.email ?? "no email provided",
                    email: user.email ?? ""
                )
                Auth.auth().currentUser?.reload()
            } else {
                // If we don't have a user, set our session to nil
                self.session = nil
            }
        }
    }

    /* Sign up a new user with Firebase Authentication */
    func signUp(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        print("sign up new user")
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }

    /* Sign in an existing user with Firebase AUthentication */
    func signIn(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        print("sign in new user")
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }

    /* Sign out the current user */
    func signOut() {
        print("sign out current user")
        do {
            try Auth.auth().signOut()
        } catch {
            
        }
    }
    
    /* Stop listening to our authentication change handler */
    func unbind () {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
}
