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
    @State private var computer = Int.random(in: 0..<2)
    @State private var score = 0
    @State private var rounds = 0
    @State private var outcomes = "Hello"
    @State private var backgrounds = ""
    @State private var options = ["👊", "🤚", "✌️"]
    var body: some View {
        ZStack {
            if rounds == 0 {
                Color(.gray)
                    .ignoresSafeArea()
            } else if backgrounds == "G" {
                Color(.green)
            } else if backgrounds == "R" {
                Color(.red)
            } else {
                Color(.yellow)
            }
            
            VStack {
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title2.bold())
                    .padding(.trailing)
                    .frame(maxWidth: .infinity, alignment: .topTrailing)
                if WorL == true {
                    Text("Try to Win")
                        .WorLTitle()
                } else {
                    Text("Try to Lose")
                        .WorLTitle()
                }
                Spacer()
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
                }
                Spacer()
                    .frame(maxHeight: 200)
                HStack {
                    ForEach(0..<3) { number in
                        Button(options[number]) {
                            emojiTapped(number, computer, WorL)
                            WorL.toggle()
                            computer = Int.random(in: 0..<2)
                            rounds += 1
                        } .font(.system(size:60))
                            .padding()
                            .shadow(color: .black, radius: 1, x: 2, y: 2)
                    }
                }
            }
        }
    }
    
    func emojiTapped(_ number: Int, _ computer: Int, _ WorL: Bool) {
        if WorL == true {
            if number == computer {
                outcomes = "Tied!"
            } else if (number == 1 && computer == 0) || (number == 2 && computer == 1) || (number == 0 && computer == 2) {
                outcomes = "Won!"
                score += 1
                backgrounds = "G"
            } else {
                outcomes = "Lost!"
                backgrounds = "R"
            }
        }
    }
    
    /*func emojiTapped(_ number: Int, _ computer: Int, _ WorL: Bool) {
        
    }*/
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
