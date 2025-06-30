import SwiftUI

// MARK: - SpaceBackgroundView
// This new view encapsulates the space-themed background elements.
// It can be easily reused as a background for any other view in the app.
struct SpaceBackgroundView: View {
    var body: some View {
        ZStack {
            // A deep space background with a radial gradient.
            RadialGradient(gradient: Gradient(colors: [Color.black, Color.purple.opacity(0.4), Color.black]),
                           center: .center,
                           startRadius: 5,
                           endRadius: 500)
                .ignoresSafeArea() // Extends the gradient to the edges of the screen.

            // Creates a random scattering of small, twinkling stars.
            ForEach(0..<100) { _ in
                Circle()
                    .fill(Color.white.opacity(Double.random(in: 0.2...0.8))) // Varying opacity for twinkle effect.
                    .frame(width: CGFloat.random(in: 1...3), height: CGFloat.random(in: 1...3))
                    .position(x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                              y: CGFloat.random(in: 0...UIScreen.main.bounds.height))
                    .animation(Animation.easeInOut(duration: Double.random(in: 2...5)).repeatForever(autoreverses: true), value: UUID()) // Gentle twinkling animation.
            }
        }
    }
}

// MARK: - ContentView
// This is the main view of the app, showcasing the space theme.
struct CView: View {
    // State variable to control the scale of the "planet" for animation.
    @State private var planetScale: CGFloat = 1.0
    // State variable to control the rotation of a "star" for animation.
    @State private var starRotation: Double = 0.0

    var body: some View {
        ZStack {
            // MARK: - App Background
            // Now using the reusable SpaceBackgroundView for the app's background.
            SpaceBackgroundView()

            // MARK: - Main Content
            VStack(spacing: 40) {
                // MARK: - App Title
                Text("COSMIC ADVENTURE")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(color: .blue, radius: 10, x: 0, y: 0) // Adds a glow effect.
                    .padding(.top, 50)

                Spacer()

                // MARK: - Animated Planet
                // A spherical shape representing a planet, with a pulsing animation.
                Circle()
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red, Color.purple]),
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing)
                    )
                    .frame(width: 150, height: 150)
                    .scaleEffect(planetScale) // Apply the scale animation.
                    .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true), value: planetScale)
                    .onAppear {
                        // Start the animation when the view appears.
                        planetScale = 1.1 // Target scale for the pulse.
                    }
                    .shadow(color: .orange.opacity(0.7), radius: 20, x: 0, y: 0) // Planet glow.


                // MARK: - Floating Star
                // A rotated text element to simulate a twinkling star or nebula.
                Text("★") // A star emoji or symbol.
                    .font(.system(size: 60))
                    .foregroundColor(.yellow)
                    .rotationEffect(.degrees(starRotation)) // Apply rotation animation.
                    .animation(Animation.linear(duration: 10).repeatForever(autoreverses: false), value: starRotation)
                    .onAppear {
                        // Start the rotation when the view appears.
                        starRotation = 360.0 // Rotate a full circle.
                    }
                    .shadow(color: .yellow.opacity(0.8), radius: 15, x: 0, y: 0)


                Spacer()

                // MARK: - Navigation / Action Buttons
                // Example buttons for a space-themed app.
                VStack(spacing: 20) {
                    Button(action: {
                        // Action for 'Explore Galaxy'
                        print("Exploring Galaxy!")
                    }) {
                        Text("Explore Galaxy")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: 250)
                            .background(Capsule().fill(LinearGradient(colors: [Color.blue, Color.cyan], startPoint: .leading, endPoint: .trailing)))
                            .shadow(color: .blue.opacity(0.5), radius: 10, x: 0, y: 5)
                    }

                    Button(action: {
                        // Action for 'Mission Briefing'
                        print("Viewing Mission Briefing!")
                    }) {
                        Text("Mission Briefing")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: 250)
                            .background(Capsule().fill(LinearGradient(colors: [Color.green, Color.teal], startPoint: .leading, endPoint: .trailing)))
                            .shadow(color: .green.opacity(0.5), radius: 10, x: 0, y: 5)
                    }
                }
                .padding(.bottom, 50)
            }
        }
    }
}

// MARK: - Preview Provider
// Provides a preview of the ContentView in Xcode's canvas.
struct CView_Previews: PreviewProvider {
    static var previews: some View {
        CView()
    }
}
