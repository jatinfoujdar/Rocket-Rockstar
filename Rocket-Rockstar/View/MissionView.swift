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
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMemeberModel(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
    
    var body: some View {
        ZStack {
            // Neon gradient background
            LinearGradient(
                colors: [Color.purple, Color.blue, Color.pink],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .center, spacing: 30) {
                    
                    // Mission Image with neon glow and funky border
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(
                                    LinearGradient(
                                        colors: [.pink, .purple, .blue, .cyan],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing),
                                    lineWidth: 6
                                )
                                .shadow(color: .pink.opacity(0.7), radius: 20, x: 0, y: 0)
                        )
                        .shadow(color: .purple.opacity(0.8), radius: 30, x: 0, y: 10)
                    
                    // Launch date funky label
                    Text(mission.formattedLaunchDate ?? "Date Unknown")
                        .font(.headline)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(
                            Capsule()
                                .fill(
                                    LinearGradient(
                                        colors: [.cyan, .blue, .purple],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .shadow(color: .cyan.opacity(0.8), radius: 15, x: 0, y: 0)
                        )
                        .shadow(color: .black.opacity(0.8), radius: 10, x: 0, y: 5)
                    
                    // Description with funky neon border
                    Text(mission.description)
                        .font(.body)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(
                                    LinearGradient(
                                        colors: [.pink, .purple, .blue],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 3
                                )
                                .background(Color.black.opacity(0.6))
                                .cornerRadius(20)
                                .shadow(color: .blue.opacity(0.8), radius: 15, x: 0, y: 0)
                        )
                        .padding(.horizontal)
                    
                    Text("Crew")
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                        .shadow(color: .pink, radius: 5, x: 0, y: 0)
                    
                    VStack(spacing: 25) {
                        ForEach(crew, id: \.astronaut.id) { crewMember in
                            NavigationLink(destination: AstronautDetailView(astronaut: crewMember.astronaut)) {
                                HStack(spacing: 20) {
                                    Image(crewMember.astronaut.id)
                                        .resizable()
                                        .frame(width: 70, height: 70)
                                        .clipShape(Circle())
                                        .overlay(
                                            Circle().stroke(LinearGradient(colors: [.pink, .purple, .blue], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 4)
                                        )
                                        .shadow(color: .purple.opacity(0.9), radius: 15)
                                    
                                    VStack(alignment: .leading, spacing: 6) {
                                        Text(crewMember.astronaut.name)
                                            .font(.title3)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                            .shadow(color: .pink, radius: 3)
                                        
                                        Text(crewMember.role.uppercased())
                                            .font(.caption)
                                            .fontWeight(.heavy)
                                            .foregroundColor(.cyan)
                                    }
                                    
                                    Spacer()
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 25)
                                        .fill(Color.black.opacity(0.3))
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(
                                            LinearGradient(colors: [.cyan, .blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing),
                                            lineWidth: 2
                                        )
                                )
                                .padding(.horizontal)
                            }
                        }
                    }
                    .padding(.vertical, 40)
                }
            }
            .navigationTitle(mission.displayName.capitalized)
            .navigationBarTitleDisplayMode(.inline)
        }
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
