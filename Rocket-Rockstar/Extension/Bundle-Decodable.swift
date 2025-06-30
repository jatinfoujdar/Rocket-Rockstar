//
//  Bundle-Decodable.swift
//  Rocket-Rockstar
//
//  Created by jatin foujdar on 30/06/25.
//

import Foundation


extension Bundle {
    func decode<T: Codable>(_ file: String)-> T{
        
        guard let url = self.url(forResource: file, withExtension: nil) else{
            fatalError("Failed to locate \(file) in bundle")
        }
        
        guard let data = try? Data(contentsOf: url) else{
            fatalError("Failed to load \(file) as Data")
        }
        
        
        let decoder = JSONDecoder()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let loaded = try? decoder.decode(T.self, from: data) else{
            fatalError("failed to decode \(file) from bundle")
        }
        
        return loaded
    }
}
