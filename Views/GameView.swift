//
//  GameView.swift
//  quizzy
//
//  Description:
//  Before a game begins, the user can pick the game category and number of questions.
//  Then the user progresses through the questions.
//  After all the questions, the user gets a summary of how they scored.
//
//  Created by Kristen Chen on 12/1/20.
//

import Foundation
import SwiftUI

struct GameView: View {
    
    @ObservedObject var gameVM: GameViewModel = GameViewModel()
    
    var body: some View {
        
        // if a game is in play (after user clicks start)
        if (gameVM.gameInPlay) {
            NavigationView {
                ScrollView {
                    VStack {
                        HStack {
                            Text("Current question: \(gameVM.qNumber + 1) / \(gameVM.numberQs, specifier: "%.0f")")
                            Spacer()
                            NavigationLink(destination: GameView()) {
                                Button(action: {gameVM.restart()}) {
                                    Text("Restart")
                                }
                            }
                        }
                        .padding()
                        .frame(width: CGFloat.screenWidth)
                        
                        QuestionCell(gameVM: gameVM)
                        
                        if (gameVM.showingAnswer) {
                            Button(action: {gameVM.next()}) {
                                Text("next")
                            }
                            .buttonStyle(AnswerStyle(bgColor: Color.myPurple))
                        }
                        
                        Spacer()
                    }
                }
                .padding(.top, calcPadding())
                .modifier(viewMod())
            }
            
        } else { // if the game has ended or not started yet
            if (gameVM.isOver) {
                NavigationView {
                    VStack {
                        Text("Game Over")
                            .font(.system(size: CGFloat.screenWidth * 0.15))
                        Text("Questions answered: \(gameVM.numberQs, specifier: "%.0f")")
                            .font(.system(size: CGFloat.screenWidth * 0.08))
                        Text("Number incorrect: \(gameVM.numIncorrect)")
                            .font(.system(size: CGFloat.screenWidth * 0.08))
                        Text("You scored: \(calcAccuracy(), specifier: "%.2f")%")
                            .font(.system(size: CGFloat.screenWidth * 0.08))
                        Button("Play again", action: {gameVM.restart()})
                            .buttonStyle(AnswerStyle(bgColor: Color.myPurple))
                    }
                    .modifier(viewMod())
                }
            } else {
                NavigationView {
                    VStack {
                        Spacer()
                        Menu("Theme: \(gameVM.theme)") {
                            Button("General Knowledge", action: {gameVM.pickTheme(theme: "General Knowledge")})
                            Button("Science & Nature", action: {gameVM.pickTheme(theme: "Science & Nature")})
                            Button("History", action: {gameVM.pickTheme(theme: "History")})
                            Button("Animals", action: {gameVM.pickTheme(theme: "Animals")})
                        }
                        .font(.system(size: UIScreen.main.bounds.height * 0.025))
                        
                        Text("Number of questions: \(gameVM.numberQs, specifier: "%.0f")")
                        Slider(value: $gameVM.numberQs, in: 1...50, step: 1)
                            .frame(width: CGFloat.screenWidth * 0.75)
                        
                        Button("Start", action: {gameVM.start()})
                            .buttonStyle(AnswerStyle(bgColor: Color.gray))
                        
                        Spacer()
                    }
                    .modifier(viewMod())
                }
            }

        }
    }
    
    func calcAccuracy() -> Double {
        return 100 * (gameVM.numberQs - Double(gameVM.numIncorrect)) / gameVM.numberQs
    }
    
    /* Calcualtes necessary top padding. */
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

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}

/* Questions page. Displays the question and answer choices. Shows correct answer choice after guessing. */
struct QuestionCell : View {
    
    @ObservedObject var gameVM: GameViewModel
    
    var body : some View {
        VStack {
            Text(gameVM.question)
                .font(.system(size: CGFloat.screenWidth * 0.07))
                .bold()
                .frame(width: CGFloat.screenWidth * 0.95)
                .padding()
            
            ForEach(0..<gameVM.answers.count, id: \.self) { index in
                if (gameVM.showingAnswer) {
                    if (index == gameVM.correctAnswerIndex) {
                        Button(action: {}) {
                            Text(gameVM.answers[index])
                        }
                        .buttonStyle(AnswerStyle(bgColor: Color.green))
                    } else {
                        Button(action: {}) {
                            Text(gameVM.answers[index])
                        }
                        .buttonStyle(AnswerStyle(bgColor: Color.red))
                    }
                } else {
                    Button(action: {gameVM.makeGuess(index: index)}) {
                        Text(gameVM.answers[index])
                    }
                    .buttonStyle(AnswerStyle(bgColor: Color.myPurple))
                }
            }
        }
    }
}


