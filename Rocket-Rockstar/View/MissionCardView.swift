//
//  MissionCardView.swift
//  Rocket-Rockstar
//
//  Created by jatin foujdar on 01/07/25.
//

import SwiftUI


struct MissionCardView: View {
    let mission: MissionModel

    var body: some View {
        VStack {
            Image(mission.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding()

            VStack {
                Text(mission.displayName)
                    .font(.headline)
                    .foregroundStyle(.white)

                Text(mission.formattedLaunchDate!)
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

