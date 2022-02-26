//
//  ContentView.swift
//  WinOrLoseRockPaperScissors
//
//  Created by Alden Luscher on 2022-02-25.
//

import SwiftUI

struct winOrLoseTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundColor(.white)
    }
}

extension View {
    func WorLTitle() -> some View {
        modifier(winOrLoseTitle())
    }
}

struct ContentView: View {
    @State private var gameOver = false
    @State private var WorL = Bool.random()
    @State private var computer = 0
    @State private var score = 0
    @State private var rounds = 0
    @State private var outcomes = ""
    @State private var backgrounds = ""
    @State private var options = ["👊", "🤚", "✌️"]
    var body: some View {
        ZStack {
            if rounds == 0 {
                Color(.gray)
                    .ignoresSafeArea()
            } else if backgrounds == "G" {
                Color(red: 0.13, green: 0.60, blue: 0.02)
                    .ignoresSafeArea()
            } else if backgrounds == "R" {
                Color(red: 0.79, green: 0.23, blue: 0.13)
                    .ignoresSafeArea()
            } else if backgrounds == "Y" {
                Color(red: 0.84, green: 0.73, blue: 0.11)
                    .ignoresSafeArea()
            }
            VStack {
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title2.bold())
                    .padding(.trailing)
                    .padding(.bottom, 0.1)
                    .frame(maxWidth: .infinity, alignment: .topTrailing)
                if WorL == true {
                    Text("Try to Win")
                        .WorLTitle()
                } else {
                    Text("Try to Lose")
                        .WorLTitle()
                }
                Spacer()
                    .frame(maxHeight:50)
                if rounds == 0 {
                    VStack {
                        Text("Choose an Emoji to Begin")
                            .foregroundColor(.white)
                            .font(.title.bold())
                        Spacer()
                        Text("🤖")
                            .font(.system(size:150))
                            .padding()
                            .shadow(color: .black, radius: 1, x: 2, y: 2)
                    }
                } else {
                    Text("You \(outcomes)")
                        .foregroundColor(.white)
                        .font(.title.bold())
                    Spacer()
                    Text("\(options[computer])")
                        .font(.system(size:150))
                        .padding()
                        .shadow(color: .black, radius: 1, x: 2, y: 2)
                }
                Spacer()
                    .frame(maxHeight: 200)
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .frame(maxWidth: .infinity, maxHeight: 120)
                        .padding(.horizontal, 20)
                        .foregroundStyle(.ultraThinMaterial)
                    HStack {
                        ForEach(0..<3) { number in
                            Button(options[number]) {
                                rounds += 1
                                if rounds != 10 {
                                    computer = Int.random(in: 0..<3)
                                    emojiTapped(number, computer, WorL)
                                    WorL.toggle()
                                } else {
                                    emojiTapped(number, computer, WorL)
                                    gameOver = true
                                }
                            } .font(.system(size:60))
                                .padding()
                                .shadow(color: .black, radius: 1, x: 2, y: 2)
                        }
                    }
                }
            }
        }.alert("Game Over", isPresented: $gameOver) {
            Button("Restart", role: .cancel) {
                rounds = 0
                score = 0
                outcomes = ""
            }
        } message: {
            Text("Great job! You won \(score) rounds!")
        }
    }
    
    func emojiTapped(_ number: Int, _ computer: Int, _ WorL: Bool) {
        if number == computer {
            outcomes = "Tied!"
            backgrounds = "Y"
        } else if WorL == true {
            if (number == 1 && computer == 0) || (number == 2 && computer == 1) || (number == 0 && computer == 2) {
                outcomes = "Won!"
                score += 1
                backgrounds = "G"
            } else {
                outcomes = "Lost!"
                backgrounds = "R"
            }
        } else {
            if (number == 0 && computer == 1) || (number == 1 && computer == 2) || (number == 2 && computer == 0) {
                outcomes = "Won!"
                score += 1
                backgrounds = "G"
            } else {
                outcomes = "Lost!"
                backgrounds = "R"
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
