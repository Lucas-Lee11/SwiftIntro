//
//  Bundle-Decode.swift
//  Moonshot
//
//  Created by Lucas Lee on 9/28/20.
//

import Foundation

extension Bundle {
    func decode<E:Codable>(_ file: String) -> E {
        guard let url:URL = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data:Data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder:JSONDecoder = JSONDecoder()
        let formatter:DateFormatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let loaded:E = try? decoder.decode(E.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }

        return loaded
    }
}
