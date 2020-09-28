//
//  ContentView.swift
//  WeSplit
//
//  Created by Lucas Lee on 9/24/20.
//  Copyright © 2020 Lucas Lee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
        
    @State var num:Int = 0
    @State var name:String = ""
    @State var selected:Int = 0
    var names:[String] = ["lucas", "chris"]
    
    var body: some View {
        NavigationView{
            Form{
               Section {
                    Text("Tap Below")
                    Button("Tapped \(num) times"){
                        self.num += 1
                    }
                    TextField("Whats ur name", text: $name)
                }
                Section {
                    Picker("Select your name", selection: $selected) {
                        ForEach(0 ..< names.count) {
                            Text(self.names[$0])
                        }
                        Text("\(name)")
                    }
                    Text("Hello World")
                    Text("Hello \(self.names[selected])")
                }
            }.navigationBarTitle("SwiftUI")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

