//
//  SignUpView.swift
//  quizzy
//
//  Description:
//  Allows user to sign up via email and password.
//
//  Created by Kristen Chen on 12/1/20.
//

import Foundation
import SwiftUI
import Firebase

struct SignUpView: View {
    
    @Binding var email: String
    @Binding var password: String
    
    @Binding var loggedIn: Bool
    @EnvironmentObject var session: SessionStore
    
    @State var isError: Bool = false
    @State var message: String = ""
    
    var body: some View {
        
        NavigationView {
            VStack {
                Text("sign up")
                    .font(.system(size: CGFloat.screenWidth * 0.2)).bold()
                    .foregroundColor(Color.white)
                
                Spacer()
                
                VStack {
                    HStack {
                        Image(systemName: "person")
                            .resizable()
                            .frame(width: CGFloat.screenWidth * 0.07,
                                   height: CGFloat.screenWidth * 0.07)
                            .foregroundColor(Color.white)
                        TextField("email", text: $email)
                            .textFieldStyle(CustomTextFieldStyle(textColor: Color.black))
                    }
                    HStack {
                        Image(systemName: "lock")
                            .resizable()
                            .frame(width: CGFloat.screenWidth * 0.07,
                                   height: CGFloat.screenWidth * 0.075)
                            .foregroundColor(Color.white)
                        SecureField("password", text: $password)
                            .textFieldStyle(CustomTextFieldStyle(textColor: Color.black))
                    }
                }
                .padding()
                
                HStack {
                    NavigationLink(destination: ContentView()) {
                        Text("sign up")
                            .onTapGesture(count: 1, perform: {
                                signUp()
                            })
                    }
                    .buttonStyle(Style1(bgColor: Color.white, txtColor: Color.myPurple))
                }
                .frame(width: CGFloat.screenWidth)
                .padding()
                
                Spacer()
            }
            .padding(.top, calcPadding())
            .background(LinearGradient(gradient: Gradient(colors: [Color.myPurple, Color.myPink, Color.myPink]), startPoint: .top, endPoint: .bottom))
            .edgesIgnoringSafeArea(.all)
        }
        .alert(isPresented: $isError) { () -> Alert in
            Alert(title: Text("Error"), message: Text(message))
        }
    }
    
    func go() {
        Auth.auth().currentUser?.reload()
    }
    
    /* If user clicks sign up. */
    func signUp() {
        // print("user sign up")
        if validEntries() {
            session.signUp(email: email, password: password) { (result, error) in
                if error != nil {
                    self.isError = true
                    self.message = error!.localizedDescription
                } else {
                    self.loggedIn = true
                }
            }
        } else {
            self.isError = true
            self.message = "Enter email/password"
        }
    }
    
    /* Checks if user's entries are valid. */
    func validEntries() -> Bool {
        if (email != "" && password != "") {
            return true
        }
        return false
    }
    
    /* Calculates needed top padding. */
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
