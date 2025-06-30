//
//  MissionView.swift
//  Rocket-Rockstar
//
//  Created by jatin foujdar on 30/06/25.
//

import SwiftUI

struct MissionView: View {
    
    let mission: MissionModel
    let crew: [CrewMemeberModel]
    
    init(mission: MissionModel, astronauts: [String: AstronautModel]) {
        self.mission = mission
   
        self.crew = mission.crew.map{member in
            
            if let astronaut = astronauts[member.name]{
                return CrewMemeberModel(role: member.role, astronaut: astronaut)
            }else{
                fatalError("Missing \(member.name)")
            }
        }
    }
    var body: some View {
           ScrollView {
               VStack(alignment: .leading) {
                   Image(mission.image)
                       .resizable()
                       .scaledToFit()
                   
                   Text(mission.formattedLaunchDate ?? "Launch date not available")
                       .font(.caption)
                       .foregroundColor(.secondary)
                       .padding(.top)
                   
                   Text(mission.description)
                       .padding(.vertical)
                   
                   Text("Crew")
                       .font(.title2)
                       .bold()
                   
                   ForEach(crew, id: \.astronaut.id) { crewMember in
                       HStack {
                           Text(crewMember.astronaut.name)
                               .font(.headline)
                           Spacer()
                           Text(crewMember.role)
                               .foregroundColor(.secondary)
                       }
                       .padding(.vertical, 4)
                   }
               }
               .padding()
           }
           .navigationTitle(mission.displayName.capitalized)
           .navigationBarTitleDisplayMode(.inline)
       }
   }


#Preview {
    let sampleAstronauts: [String: AstronautModel] = [
        "armstrong": AstronautModel(id: "armstrong", name: "Neil Armstrong", description: "First person on the Moon")
    ]
    
    let sampleMission = MissionModel(
        id: 11,
        launchDate: Date(),
        crew: [MissionModel.CrewRole(name: "armstrong", role: "Commander")],
        description: "Apollo 11 was the spaceflight that first landed humans on the Moon."
    )
    
    MissionView(mission: sampleMission, astronauts: sampleAstronauts)
}
