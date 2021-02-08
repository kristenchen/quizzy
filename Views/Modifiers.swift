//
//  Modifiers.swift
//  quizzy
//
//  Created by Kristen Chen on 12/3/20.
//

import Foundation
import SwiftUI

struct AnswerStyle: ButtonStyle {
    var bgColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: CGFloat.screenWidth * 0.06))
            .frame(width: CGFloat.screenWidth * 0.62)
            .padding(CGFloat.screenWidth * 0.03)
            .foregroundColor(Color.white)
            .background(
                RoundedRectangle(cornerRadius: 50.0)
                    .foregroundColor(bgColor)
                    .frame(width: CGFloat.screenWidth * 0.7)
            )
            .padding()
    }
}

struct viewMod: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(minWidth: 0, maxWidth: CGFloat.screenWidth, minHeight: 0, maxHeight: .infinity)
            .background(LinearGradient(gradient: Gradient(colors: [Color.myPurple, Color.myPink, Color.myPink]), startPoint: .top, endPoint: .bottom))
            .edgesIgnoringSafeArea(.top)
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
    }

}

struct Style1: ButtonStyle {
    var bgColor: Color
    var txtColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 50.0)
                .foregroundColor(bgColor)
                .frame(width: CGFloat.screenWidth * 0.65,
                       height: CGFloat.screenHeight * 0.1)
            configuration.label
                .frame(width: CGFloat.screenWidth,
                       height: CGFloat.screenHeight * 0.125)
                .font(.largeTitle)
                .foregroundColor(txtColor)
        }
    }
}

struct CustomTextFieldStyle: TextFieldStyle {
    
    var textColor: Color
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .frame(width: CGFloat.screenWidth * 0.7)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .foregroundColor(textColor)
            .font(.system(size: 30))
    }
}
