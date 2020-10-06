//
//  Prospect.swift
//  HotProspects
//
//  Created by Lucas Lee on 10/2/20.
//

import Foundation
import UserNotifications

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    var date = Date()
    fileprivate(set) var isContacted = false
}

class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    static let saveKey = "SavedData"
    

    init() {
        if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                self.people = decoded
                return
            }
        }
        
        self.people = []
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(people) {
            UserDefaults.standard.set(encoded, forKey: Self.saveKey)
        }
    }
}
