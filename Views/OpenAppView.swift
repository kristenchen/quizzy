//
//  OpenAppView.swift
//  quizzy
//
//  Description:
//  If a user isn't signed in, they can either sign up for an account or log in.
//
//  Created by Kristen Chen on 12/1/20.
//

import Foundation

import SwiftUI

struct OpenAppView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var loggedIn: Bool = false
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        
        NavigationView {
            VStack {
                Text("quizzy")
                    .font(.system(size: CGFloat.screenWidth * 0.2)).bold()
                    .foregroundColor(Color.white)
                
                Spacer()
                Spacer()
                
                VStack {
                    NavigationLink(destination: SignUpView(email: $email, password: $password, loggedIn: $loggedIn)) {
                        Text("sign up")
                    }
                    .buttonStyle(Style1(bgColor: Color.white, txtColor: Color.myPurple))
                    NavigationLink(destination: LoginView(email: $email, password: $password, loggedIn: $loggedIn)) {
                        Text("log in")
                    }
                    .buttonStyle(Style1(bgColor: Color.white, txtColor: Color.myPurple))
                }
                .frame(width: CGFloat.screenWidth)
                
                Spacer()
            }
            .padding(.top, calcPadding())
            .background(LinearGradient(gradient: Gradient(colors: [Color.myPurple, Color.myPink, Color.myPink]), startPoint: .top, endPoint: .bottom))
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    /* Calculates necessary top padding. */
    func calcPadding() -> CGFloat {
        var padding: CGFloat = 0.0
        switch CGFloat.screenHeight {
            case 568.0: padding = 94.0 + 6.0
            case 667.0: padding = 96.0 + 10.0
            case 736.0: padding = 96.0 + 10.0
            case 812.0: padding = 106.0 + 10.0
            case 896.0: padding = 106.0 + 10.0
            default:
                padding = 106.0
            }
        return padding
    }
}
