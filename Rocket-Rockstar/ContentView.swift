//
//  ContentView.swift
//  Rocket-Rockstar
//
//  Created by jatin foujdar on 30/06/25.
//

import SwiftUI

struct ContentView: View {
    
    let astronauts: [String: AstronautModel] = Bundle.main.decode("astronauts.json")
    let missions: [MissionModel] = Bundle.main.decode("missions.json")
    
    let columns = [GridItem(.adaptive(minimum: 150))]
    
    var body: some View {
        
        NavigationStack{
            ScrollView{
                LazyVGrid(columns: columns){
                    ForEach(missions) { mission in
                        NavigationLink{
                            MissionView(missions : mission, astronauts: astronauts)
                        }label:{
                            VStack{
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding()
                                
                                VStack{
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    
                                    Text(mission.formattedLaunchDate)
                                        .font(.caption)
                                        .foregroundStyle(.white.opacity(0.4))
                                    
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                
                            }
                            .clipShape(.rect(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.blue, lineWidth: 2)
                            )
                        }
                    }
                }
                .padding([.horizontal, .bottom])
            }
            .navigationTitle("Rocket Rockstar")
        }
    }
}

#Preview {
    ContentView()
}
