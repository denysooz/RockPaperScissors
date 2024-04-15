//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Denis Dareuskiy on 24.02.24.
//

import SwiftUI

struct ContentView: View {

    var elementsStart = ["✊","✋", "✌️"]
    var elementsStatus = [true, false]
    var elementsEndTrue = ["✌️", "✊", "✋"]
    var elementsEndFalse = [ "✋", "✌️", "✊"]
    @State var alertText = ""
    @State var alertTitle = ""
    @State var showingScore = false
    @State var showingRestart = false
    @State var elementIndex = Int.random(in: 0...2)
    @State var statusIndex = Int.random(in: 0...1)
    @State var elementsButtons = ["✊","✋", "✌️"]
    @State var score = 0

    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.8, green: 0.3, blue: 0.8), location: 0.3),
                .init(color: Color(red: 0.3, green: 0.8, blue: 0.8), location: 0.7)
            ],center: .top, startRadius: 100, endRadius: 900)
            .ignoresSafeArea()
            VStack{
                Spacer()
                Text("Rock-Paper-Scissors")
                    .font(.largeTitle.weight(.bold))
                    .font(.system(size:70))
                    .foregroundColor(.white)

                Spacer()
                VStack(spacing:20) {
                    Spacer()
                    Spacer()

                    Text(elementsStart[elementIndex])
                        .font(.system(size:70))
                        .shadow(radius: 5)
                    Text(elementsStatus[statusIndex] ? "Win" : "Lose")
                        .font(.title.bold())
                        .foregroundStyle(elementsStatus[statusIndex] ? .green : .red)
                    HStack {
                        Button {
                            elementTapped(elementsButtons[0], elementIndex, statusIndex)
                        } label: {
                            Text(elementsButtons[0])
                                .font(.system(size:70))
                        }
                        .shadow(radius: 5)
                        Button {
                            elementTapped(elementsButtons[1], elementIndex, statusIndex)
                        } label: {
                            Text(elementsButtons[1])
                                .font(.system(size:70))
                        }
                        .shadow(radius: 5)
                        Button {
                            elementTapped(elementsButtons[2], elementIndex, statusIndex)
                        } label: {
                            Text(elementsButtons[2])
                                .font(.system(size:70))
                        }
                        .shadow(radius: 5)
                    }
                    Spacer()
                    Text("Score: \(score)")
                        .foregroundStyle(.primary)
                        .font(.title.bold())

                    Spacer()
                }
                .frame(maxWidth: 300)
                .frame(maxHeight: 390)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                .alert(alertTitle, isPresented: $showingScore) {
                    Button("Continue", action: goNext)
                } message: {
                    Text(alertText)
                }
                .alert("Good game!", isPresented: $showingRestart) {
                    Button("Restart", action: restart)
                } message: {
                    Text("Your score is \(score)")
                }
                Spacer()
                Spacer()
            }
            .padding()
    }
}

    func elementTapped(_ element: String, _ trueElementIndex: Int, _ statusIndex: Int) {
        let correctElement = elementsStatus[statusIndex] ? elementsEndTrue[trueElementIndex] : elementsEndFalse[trueElementIndex]
        if element == correctElement {
            score += 1
            alertTitle = "Correct"
            alertText = "Your score: \(score)"
        } else {
            score -= 1
            alertTitle = "Wrong"
            alertText = "Correct version: \(correctElement)\nYou choosed \(element)\nYour score: \(score)"
        }
        showingScore = true
        if score == 3 {
            showingRestart = true
        }
    }

    func goNext() {
        elementIndex = Int.random(in: 0...2)
        statusIndex = Int.random(in: 0...1)
    }

    func restart() {
        score = 0
    }
}

#Preview {
    ContentView()
}
