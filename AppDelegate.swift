//
//  AppDelegate.swift
//  quizzy
//
//  Created by Kristen Chen on 11/29/20.
//

import Foundation
import UIKit
import Firebase
import Resolver

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
