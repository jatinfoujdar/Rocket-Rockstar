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
        NavigationStack {
            ZStack {
               
                SpaceThemeView()
                    .ignoresSafeArea()
                
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(missions) { mission in
                            NavigationLink {
                                MissionView(mission: mission, astronauts: astronauts)
                            } label: {
                                MissionCardView(mission: mission)
                                    .background(Color.black.opacity(0.2))
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .padding([.horizontal, .bottom])
                }
                .navigationTitle("Rocket Rockstar")
                .toolbarBackground(Color.black.opacity(0.9), for: .navigationBar)
                .toolbarColorScheme(.dark, for: .navigationBar)
            }
        }
    }
}

#Preview {
    ContentView()
}

