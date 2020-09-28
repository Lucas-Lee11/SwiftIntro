//
//  ContentView.swift
//  BetterSleep
//
//  Created by Lucas Lee on 9/26/20.
//  Copyright © 2020 Lucas Lee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var wakeUp:Date = defaultWakeTime
    @State var sleepAmount:Double = 8.0
    @State var coffeeAmount:Int = 1
    @State var alertTitle:String = ""
    @State var alertMessage:String = ""
    @State var showingAlert:Bool = false
    @State var time:String = ""
    
    static var defaultWakeTime:Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    func calculateBedtime() -> Void{
        let components:DateComponents = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour:Int = (components.hour ?? 0) * 60 * 60
        let minute:Int = (components.minute ?? 0) * 60
        let model:SleepCalculator = SleepCalculator()
        
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime:Date = wakeUp - prediction.actualSleep
            let formatter = DateFormatter()
            formatter.timeStyle = .short

            alertMessage = formatter.string(from: sleepTime)
            time = formatter.string(from: sleepTime)
            alertTitle = "Your ideal bedtime is"
        }catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        
        showingAlert = true
    }

    
    var body: some View {
        NavigationView{
            Form {
                VStack{
                    Text("Wake up time").font(.headline)
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute).labelsHidden().datePickerStyle(WheelDatePickerStyle())
                }
                VStack{
                    Text("Desired amount of sleep").font(.headline)
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                }
                VStack{
                    Text("Daily coffee intake").font(.headline)
                    Picker("Coffee Amount", selection: $coffeeAmount) {
                        ForEach(0 ..< 21) {
                            Text("\($0) \($0 == 1 ? "cup" : "cups")")
                        }
                    }
                }
                Section{
                    Text("\(time)").font(.headline)
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
            }
            .navigationBarTitle("BetterSleep")
            .navigationBarItems(trailing:
                Button(action: self.calculateBedtime) {
                    Text("Calculate")
                }
            )

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
