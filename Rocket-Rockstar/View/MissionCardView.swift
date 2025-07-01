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
        VStack(spacing: 12) {
            // Mission Image
            Image(mission.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(radius: 8)

            // Mission Name
            Text(mission.displayName.capitalized)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)

            // Safe Launch Date Display
            Text(mission.formattedLaunchDate ?? "Unknown Launch")
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            // Simulated glass look with gradient & opacity
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.white.opacity(0.08),
                            Color.white.opacity(0.02)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                )
        )
        .shadow(color: Color.purple.opacity(0.3), radius: 10, x: 0, y: 5)
        .padding(5)
    }
}



