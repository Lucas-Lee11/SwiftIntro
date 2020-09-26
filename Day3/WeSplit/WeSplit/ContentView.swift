//
//  ContentView.swift
//  WeSplit
//
//  Created by Lucas Lee on 9/24/20.
//  Copyright © 2020 Lucas Lee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2) //+2 because numberOfPeople refers to row#
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }
    var checkTotal:Double {
        let orderAmount = Double(checkAmount) ?? 0
        let tipSelection = Double(tipPercentages[tipPercentage])
        
        return orderAmount * (1 + tipSelection/100)
        
    }
    
    var body: some View {
        NavigationView{
            Form{
                TextField("Amount", text: $checkAmount)
                Text("$\(checkAmount)").keyboardType(.decimalPad)
                Picker("Number of people", selection: $numberOfPeople, content:{
                  ForEach(2 ..< 100) { number in
                      Text("\(number) people")
                  }
                })
                Picker("Tip percentage", selection: $tipPercentage) {
                  ForEach(0 ..< tipPercentages.count) {
                      Text("\(self.tipPercentages[$0])%")
                  }
                }.pickerStyle(SegmentedPickerStyle())
                Text("With Tip: $\(checkTotal, specifier: "%.2f")")
                Text("Per Person: $\(totalPerPerson, specifier: "%.2f")")
                
            }.navigationBarTitle("WeSplit")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
