//
//  StatsView.swift
//  quizzy
//
//  Description:
//  Shows player statistics.
//
//  Created by Kristen Chen on 12/1/20.
//

import Foundation
import SwiftUI
import SwiftUICharts

struct StatsView: View {
    
    @ObservedObject var statsVM: StatsViewModel
    
    var body : some View {
        ScrollView {
            VStack {
                Text("Statistics")
                    .font(.system(size: CGFloat.screenWidth * 0.15))
                    .bold()
                    .foregroundColor(Color.white)
                
                AccuracyCell(statsVM: statsVM)
                LineChartCell(statsVM: statsVM)
                PieChartCell(statsVM: statsVM)
            }
        }
        .onAppear(perform: {statsVM.refresh()})
        .padding(.top, calcPadding())
        .modifier(viewMod())
    }
    
    func calcPadding() -> CGFloat {
        var padding: CGFloat = 0.0
        switch CGFloat.screenHeight {
        case 568.0: padding = 40.0
        case 667.0: padding = 55.0
        case 736.0: padding = 55.0
        case 812.0: padding = 55.0
        case 896.0: padding = 55.0
        default:
            padding = 106.0
        }
        return padding
    }
}

/* Creates the view of a player's overall accuracy. */
struct AccuracyCell : View {
    @ObservedObject var statsVM: StatsViewModel
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0)
                .foregroundColor(Color.myPurple)
                .frame(width: CGFloat.screenWidth * 0.9)
            
            VStack {
                Text("Overall accuracy:")
                    .bold()
                Text("\(statsVM.accuracy, specifier: "%.2f")%")
            }
            .font(.system(size: CGFloat.screenWidth * 0.1))
            .foregroundColor(Color.white)
            .padding()

        }.fixedSize()
    }
}

/* Displays a bar chart of a player's accuracy for all the games. Can be filtered to show only specific categories. */
struct LineChartCell : View {
    @ObservedObject var statsVM: StatsViewModel
    
    var body: some View {
        
        VStack {
            VStack {
                Text("Accuracy per game")
                    .foregroundColor(Color.myPurple)
                    .bold()
                Spacer()
                Menu("Filter: \(statsVM.barFilter)") {
                    Button("All", action: {statsVM.filterBarData(theme: "All")})
                    Button("General", action: {statsVM.filterBarData(theme: "General Knowledge")})
                    Button("Nature", action: {statsVM.filterBarData(theme: "Science & Nature")})
                    Button("History", action: {statsVM.filterBarData(theme: "History")})
                    Button("Animals", action: {statsVM.filterBarData(theme: "Animals")})
                }
            }
            .font(.system(size: UIScreen.main.bounds.height * 0.03))
            .padding()
            BarChartView(data: ChartData(values: statsVM.barData), title: "Percent", form: ChartForm.medium, valueSpecifier: "%.2f")
                .padding()
        }
    }
}

/* Displays a pie chart of a user's incorrect vs correct percentage for each category. */
struct PieChartCell : View {
    @ObservedObject var statsVM: StatsViewModel
    
    var body: some View {
        VStack {
            VStack {
                VStack {
                    Text("Percent (in)correct")
                        .foregroundColor(Color.myPurple)
                        .bold()
                    Text("per category")
                        .foregroundColor(Color.myPurple)
                        .bold()
                }
                Spacer()
                Menu("Filter: \(statsVM.pieFilter)") {
                    Button("General", action: {statsVM.filterPieData(theme: "General Knowledge")})
                    Button("Nature", action: {statsVM.filterPieData(theme: "Science & Nature")})
                    Button("History", action: {statsVM.filterPieData(theme: "History")})
                    Button("Animals", action: {statsVM.filterPieData(theme: "Animals")})
                }
            }
            .font(.system(size: UIScreen.main.bounds.height * 0.03))
            .padding()
            
            PieChartView(data: statsVM.pieData, title: "Percentages", form: ChartForm.medium)
                .padding()
        }
    }
}

