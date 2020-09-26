//
//  ContentView.swift
//  Modifiers
//
//  Created by Lucas Lee on 9/26/20.
//  Copyright © 2020 Lucas Lee. All rights reserved.
//

import SwiftUI

struct BigBlue: ViewModifier{
    func body(content: Content) -> some View {
        content.font(.largeTitle).foregroundColor(.blue)
    }
}

struct ContentView: View {
    var body: some View {
        Text("Hello, World!").modifier(BigBlue())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
