//
//  Mission.swift
//  Moonshot
//
//  Created by Lucas Lee on 9/28/20.
//

import Foundation


struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    let id: Int
    let launchDate: Date? //Apollo 1 does not have one
    let crew: [CrewRole]
    let description: String
    var displayName: String {"Apollo \(id)"}
    var image: String {"apollo\(id)"}
    var formattedLaunchDate: String {
        if let launchDate:Date = launchDate {
            let formatter:DateFormatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }
    
    
}
