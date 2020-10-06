//
//  DiceView.swift
//  DiceRoll
//
//  Created by Lucas Lee on 10/5/20.
//

import SwiftUI

struct Roll:Codable, Identifiable{
    var id:UUID = UUID()
    var num:Int
}

class Rolls:ObservableObject{
    @Published var rolls:[Roll]
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "Rolls") {
            if let decoded = try? JSONDecoder().decode([Roll].self, from: data) {
                self.rolls = decoded
                return
            }
        }
        
        self.rolls = []
    }
    
    func save(){
        if let encoded = try? JSONEncoder().encode(rolls) {
            UserDefaults.standard.set(encoded, forKey: "Rolls")
        }
    }
    
    func total() -> Int{
        return rolls.reduce(0, {total, roll in
            total + roll.num
        })
    }
    
    func add(_ num:Roll){
        rolls.append(num)
    }
    
    func delete(_ index:IndexSet){
        rolls.remove(atOffsets: index)
    }
    
    func clear(){
        rolls = []
    }
}

struct DiceView: View {
    @State var image = "die.face.1"
    @EnvironmentObject var rolls:Rolls
    
    
    
    
    func roll(){
//        for _ in 1 ... 10{
//            self.image = "die.face." + String(Int.random(in: 1 ... 6))
//            Thread.sleep(forTimeInterval: 0.1)
//        }
        let result = Int.random(in: 1 ... 6)
        self.image = "die.face." + String(result)
        rolls.add(Roll(num : result))
    }
    
    
    
    var body: some View {
        NavigationView{
            VStack{
                Image(systemName: image)
                    .resizable()
                    .frame(width: 64.0, height: 64.0)
                Button(action:{
                    self.roll()
                }){
                    Text("Roll It!")
                        .font(.title)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .clipShape(Capsule())
                }
                
                
            }.navigationTitle("Roll Die")
        }
    }
}
