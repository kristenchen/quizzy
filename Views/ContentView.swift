//
//  ContentView.swift
//
//  Description:
//  If a user is logged in, it allows users to navigate through the game page, player stats page, or their own profile.
//  If a user is not logged in, they can log in or sign up.
//
//  quizzy
//
//  Created by Kristen Chen on 11/25/20.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var session: SessionStore
    @ObservedObject var statsVM: StatsViewModel = StatsViewModel()

    func getUserAuth() {
        session.configureUserAuth()
    }
    
    var body: some View {
        Group {
            if session.session != nil {
                TabView {
                    GameView()
                        .tabItem {
                            Image(systemName: "gamecontroller.fill")
                            Text("play")
                        }

                    StatsView(statsVM: statsVM)
                        .tabItem {
                            Image(systemName: "chart.pie.fill")
                            Text("Statistics")
                        }

                    ProfileView()
                        .tabItem {
                            Image(systemName: "person.crop.circle.fill")
                            Text("Profile")
                        }
                }
                .onAppear(perform: {statsVM.refresh()}) // sets up user stats upon log in
            } else {
                OpenAppView()
            }
        }
        .onAppear(perform: getUserAuth) // immediately checks if a user is logged in
    }
}
