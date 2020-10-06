//
//  ResultView.swift
//  DiceRoll
//
//  Created by Lucas Lee on 10/5/20.
//

import SwiftUI

struct ResultView: View {
    @EnvironmentObject var rolls:Rolls
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    HStack{
                        Text("Total:")
                        Spacer()
                        Text("\(rolls.total())")
                    }
                }
                Section{
                    List{
                        ForEach(rolls.rolls){roll in
                            HStack{
                                Text("\(roll.num)")
                                Spacer()
                                Image(systemName: "die.face.\(roll.num)")
                            }
                        }.onDelete{ indexSet in
                            rolls.delete(indexSet)
                        }
                    }
                }
                
            }
            .navigationBarTitle("Roll Results")
            .navigationBarItems(leading: EditButton(), trailing: Button("Clear"){
                withAnimation{
                    self.rolls.clear()
                }
            })
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView()
    }
}
