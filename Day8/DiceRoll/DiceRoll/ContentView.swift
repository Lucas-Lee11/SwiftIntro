//
//  ContentView.swift
//  DiceRoll
//
//  Created by Lucas Lee on 10/5/20.
//

import SwiftUI

struct ContentView: View {
    var rolls:Rolls = Rolls()
    
    var body: some View {
        TabView{
            DiceView()
                .tabItem {
                    Image(systemName: "die.face.5")
                    Text("Dice")
                }
            ResultView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Results")
                }
        }.environmentObject(rolls)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
