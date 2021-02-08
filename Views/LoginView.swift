//
//  LoginView.swift
//
//  Description:
//  Allows user to sign in via email and password.
//
//  quizzy
//
//  Created by Kristen Chen on 11/29/20.
//

import SwiftUI

struct LoginView: View {
    
    @Binding var email: String // user inputs email
    @Binding var password: String // user inputs password
    
    @Binding var loggedIn: Bool // is user logged in?
    @EnvironmentObject var session: SessionStore
    
    @State var isError: Bool = false // does log in error?
    @State var message: String = "" // error message
    
    var body: some View {
        
        NavigationView {
            VStack {
                VStack {
                    Text("log in")
                        .font(.system(size: CGFloat.screenWidth * 0.2)).bold()
                        .foregroundColor(Color.white)
                }
                
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
                        Text("log in")
                            .onTapGesture(count: 1, perform: {
                                logIn()
                            })
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
        .alert(isPresented: $isError) { () -> Alert in
            Alert(title: Text("Error"), message: Text(message))
        }
    }
    
    /* User clicks log in. */
    func logIn() {
        if validEntries() {
            session.signIn(email: email, password: password) { (result, error) in
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
    
    /* Checks if email and password are valid. */
    func validEntries() -> Bool {
        if (email != "" && password != "") {
            return true
        }
        return false
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
