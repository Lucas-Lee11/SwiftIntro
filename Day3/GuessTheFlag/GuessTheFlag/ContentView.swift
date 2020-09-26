//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Lucas Lee on 9/25/20.
//  Copyright © 2020 Lucas Lee. All rights reserved.
//

import SwiftUI

struct FlagImage:View{
    var img:Image

    var body:some View{
        img.renderingMode(.original).clipShape(Capsule()).overlay(Capsule().stroke(Color.black, lineWidth: 1)).shadow(color: .black, radius: 2)
    }
}

struct ContentView: View {
    @State var showingScore = false
    @State var scoreTitle = ""
    @State var score = 0
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0 ... 2)
    
    func flagTapped(_ number: Int, _ country: String) {
        if number == correctAnswer {
            scoreTitle = "Correct, that is the flag of \(country)"
            score += 1
        }
        else {scoreTitle = "Wrong, that is the flag of \(country), the flag of \(countries[correctAnswer]) was number \(correctAnswer + 1)"}

        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack {
                VStack{
                    Text("Tap the flag of") .foregroundColor(.white).frame(maxWidth: .infinity)
                    Text(countries[correctAnswer]) .foregroundColor(.white).font(.largeTitle).fontWeight(.black)
                }
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number, self.countries[number])
                    }){FlagImage(img: Image(self.countries[number]))}
                }
                .alert(isPresented: $showingScore) {
                    Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")) {
                        self.askQuestion()
                    })
                }
                Text("Score: \(score)") .foregroundColor(.white).frame(maxWidth: .infinity)
                Spacer()
            }
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
