//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Lucas Lee on 9/26/20.
//  Copyright © 2020 Lucas Lee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var shouldWin:Bool = Bool.random()
    @State var compChoice:Int = Int.random(in: 0 ... 2)
    @State var playChoice:Int = 0
    @State var score:Int = 0
    @State var games:Int = 0
    @State var showAlert:Bool = false
    @State var finish:Bool = false
    @State var title:String = ""
    
    let choices:[String] = ["Rock", "Paper", "Scissors"]
    let symbols:[String] = ["square", "paperclip","scissors"]
    
    func shuffle () -> Void {
        shouldWin = Bool.random()
        compChoice = Int.random(in: 0 ... 2)
        if games >= 10 {finish = true}
    }
    
    func outcome (comp:Int, play:Int) -> Bool {
        if play > comp {return true}
        else if play == 0 && comp == 2 {return true}
        else {return false}
    }
    
    func play () -> Void{
        if(compChoice == playChoice){
            title = "Pick an option different than the computer"
        }
        else if outcome(comp: compChoice, play: playChoice) == shouldWin {
            title = "You Scored"
            score += 1
            games += 1
        }
        else {
            title = "Wrong Choice"
            games += 1
        }
    }
    
    
    var body: some View {
        NavigationView{
            ZStack{
                Form{
                   Section{
                       Text("Computer Chose: \(choices[compChoice])")
                       Text("Aim To: \(shouldWin ? "Win" : "Lose")")
                       .alert(isPresented: $finish){
                           Alert(title:Text("The game is finished"), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")){
                               self.score = 0
                               self.games = 0
                               self.shuffle()
                           })
                       }
                   }
                   Section{
                       Picker("Pick an option", selection: $playChoice) {
                         ForEach(0 ..< choices.count) {
                           Text("\(self.choices[$0])")  // + Text(Image(systemName: "\(self.symbols[$0])")))
                         }
                       }.pickerStyle(SegmentedPickerStyle())
                       Button(action : {
                           self.play()
                           self.showAlert = true
                       }){
                           Text("Play")
                       }
                       .alert(isPresented: $showAlert){
                           Alert(title: Text("\(title)"), message: Text("Hit continue to play again"), dismissButton: .default(Text("Continue")) {
                               self.shuffle()
                           })
                       }
                   }
               }
            }.navigationBarTitle("RockPaperScissors")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
