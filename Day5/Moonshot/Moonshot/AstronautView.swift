//
//  AstronautView.swift
//  Moonshot
//
//  Created by Lucas Lee on 9/29/20.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    var missions:[Mission] = Bundle.main.decode("missions.json")
    
    init(astronaut: Astronaut) { //checks through list of all Missions and compares with astronaut
        self.astronaut = astronaut
        var matches = [Mission]()
        

        for mission in missions {
            if let _:Mission.CrewRole = mission.crew.first(where: { $0.name == astronaut.id }) {
                matches.append(mission)
            }
        }
            

        self.missions = matches
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    HStack{
                        ForEach(missions){mission in
                            Text("\(mission.displayName)")
                        }
                    }

                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] =  Bundle.main.decode("astronauts.json")

    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
