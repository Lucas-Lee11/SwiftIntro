//
//  ContentView.swift
//  TemperatureChange
//
//  Created by Lucas Lee on 9/25/20.
//  Copyright © 2020 Lucas Lee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var inScale:Int = 0
    @State var outScale:Int = 0
    @State var input:String = ""
    let scales:[String] = ["Fahrenheit", "Celsius", "Kelvin"]
    
    var output:Double{
        let i:String = scales[self.inScale]
        let o:String = scales[self.outScale]
        let temp:Double = Double(input) ?? 0
        
        func fToC(_ f:Double) -> Double{return (f - 32) * (5.0/9.0)}
        func cToF(_ c:Double) -> Double{return (c * 9.0/5.0) + 32}
        func kToC(_ k:Double) -> Double{return k - 273.15}
        func cToK(_ c:Double) -> Double{return c + 273.15}
        
        var ctemp:Double {
            if(i == "Fahrenheit"){return fToC(temp)}
            else if(i == "Kelvin"){return kToC(temp)}
            else {return temp}
        }
        
        if(o == "Fahrenheit"){return cToF(ctemp)}
        else if(o == "Kelvin"){return cToK(ctemp)}
        else {return ctemp}
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    Picker("Input Scale", selection: $inScale) {
                        ForEach(0 ..< scales.count) {
                          Text("\(self.scales[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    TextField("Degrees \(self.scales[inScale])", text: $input)
                }
                Section{
                    Picker("Output Scale", selection: $outScale) {
                        ForEach(0 ..< scales.count) {
                          Text("\(self.scales[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    Text("\(output, specifier:"%.2f")")
                }
            }.navigationBarTitle("TemperatureChange")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
