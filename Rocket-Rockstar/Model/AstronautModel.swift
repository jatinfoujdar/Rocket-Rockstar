//
//  AstronautModel.swift
//  Rocket-Rockstar
//
//  Created by jatin foujdar on 30/06/25.
//
import Foundation


struct AstronautModel: Codable,Identifiable {
    
    let id: String
    let name: String
    let description: String
}


struct CrewMemeberModel{
    let role: String
    let astronaut: AstronautModel
}
