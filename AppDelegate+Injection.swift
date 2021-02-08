//
//  AppDelegate+Resolver.swift
//  quizzy
//
//  Created by Kristen Chen on 12/3/20.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        register { SessionStore() }.scope(application)
        register { FirestoreGameRepository() as FirestoreGameRepository }.scope(application)
    }
}
