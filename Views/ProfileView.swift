//
//  ProfileView.swift
//  quizzy
//
//  Description:
//  Shows the user's email and allows the user to log out.
//
//  Created by Kristen Chen on 12/1/20.
//

import Foundation
import SwiftUI
import Firebase

struct ProfileView: View {
    
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 10.0)
                    .foregroundColor(Color.ltPink)
                    .frame(width: CGFloat.screenWidth * 0.9)
                
                VStack (alignment: .leading) {
                    Text("Email:")
                        .font(.system(size: CGFloat.screenWidth * 0.1))
                        .bold()
                    Text(session.session?.email ?? "no email")
                }
                .frame(width: CGFloat.screenWidth * 0.8)
                .foregroundColor(Color.myPurple)
                .padding()
                
            }
            .fixedSize()
            .padding()
            
            Spacer()
            Spacer()
            Button(action: session.signOut) {
                Text("sign out")
            }
            .buttonStyle(Style1(bgColor: Color.myPurple, txtColor: Color.white))
            .padding()
            Spacer()
        }
        .padding(.top, calcPadding())
        .modifier(viewMod())
    }
    
    /* Calculates necessary top padding. */
    func calcPadding() -> CGFloat {
        var padding: CGFloat = 0.0
        switch CGFloat.screenHeight {
        case 568.0: padding = 30.0
        case 667.0: padding = 45.0
        case 736.0: padding = 45.0
        case 812.0: padding = 45.0
        case 896.0: padding = 45.0
        default:
            padding = 106.0
        }
        return padding
    }
}
