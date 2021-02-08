//
//  quizzyApp.swift
//  quizzy
//
//  Created by Kristen Chen on 11/25/20.
//

import SwiftUI

@main
struct quizzyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(SessionStore())
        }
    }
}
