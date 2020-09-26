//
//  ContentView.swift
//  GuessFlag
//
//  Created by Lucas Lee on 9/25/20.
//  Copyright © 2020 Lucas Lee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var showingAlert = false
    let myAlert =  Alert(title: Text("Hello SwiftUI!"), message: Text("This is some detail message"), dismissButton: .default(Text("OK")))
    
    var body: some View {
        NavigationView{
            VStack(spacing: 20) {
                HStack(spacing: 20) {
                    Text("One")
                    Text("One")
                    Text("One")
                }
                HStack(spacing: 20) {
                    Text("One")
                    Image(systemName: "pencil")
                    Text("One")
                }
                ZStack {
                   RadialGradient(gradient: Gradient(colors: [.blue, .green]), center: .center, startRadius: 20, endRadius: 200)
                    Text("Your content")
                }
                ZStack{
                    Button(action: {
                        self.showingAlert = true
                    }) {
                        HStack(spacing: 10) {
                            Image(systemName: "pencil")
                            Text("Edit")
                        }
                    }
                    .alert(isPresented: $showingAlert) {myAlert}
                }
            }.navigationBarTitle("Hello World")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
