//
//  MissionModel.swift
//  Rocket-Rockstar
//
//  Created by jatin foujdar on 30/06/25.
//

import Foundation

struct MissionModel: Codable, Identifiable {
    
    struct CrewRole: Codable{
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "apollo \(id)"
    }
    
    var image: String{
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String? {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
}
