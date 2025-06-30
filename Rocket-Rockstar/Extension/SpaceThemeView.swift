import SwiftUI

// MARK: - SpaceStar Struct

/// Represents a single star particle in the space theme animation.
struct SpaceStar: Identifiable {
    let id = UUID() // Unique identifier for ForEach
    var x: CGFloat     // X-coordinate on screen
    var y: CGFloat     // Y-coordinate on screen
    var opacity: Double // Transparency of the star (for fading/twinkling)
    var scale: Double  // Size multiplier of the star
    var rotation: Angle // Rotation angle of the star
    var speed: Double  // How fast the star moves (drifts)
    var color: Color   // Color of the star (e.g., yellow, white, blue)
    var isTwinkling: Bool // Flag to enable a more pronounced twinkling effect
}

// MARK: - SpaceThemeView (Main View)

/// A SwiftUI view that displays a space-themed background with falling/drifting stars.
struct SpaceThemeView: View {
    @State private var stars: [SpaceStar] = [] // Array to hold all star particles
    // Timer to update star positions and opacities regularly
    let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()

    // MARK: Background Specific States (for Abstract Blurs & Bokeh)
    @State private var circle1Offset: CGSize = .zero
    @State private var circle2Offset: CGSize = .zero
    @State private var circle3Offset: CGSize = .zero

    var body: some View {
        ZStack {
            // MARK: 1. Background - Abstract Blurs & Bokeh

            Color.black.edgesIgnoringSafeArea(.all) // Base black background

            // First blurred circle
            Circle()
                .fill(Color.purple.opacity(0.1))
                .frame(width: 300, height: 300)
                .offset(circle1Offset)
                .blur(radius: 80)
                .onAppear {
                    // Animate offset for subtle movement
                    withAnimation(Animation.easeInOut(duration: 20).repeatForever(autoreverses: true)) {
                        circle1Offset = CGSize(width: 150, height: -100)
                    }
                }

            // Second blurred circle
            Circle()
                .fill(Color.orange.opacity(0.08))
                .frame(width: 250, height: 250)
                .offset(circle2Offset)
                .blur(radius: 70)
                .onAppear {
                    withAnimation(Animation.easeInOut(duration: 18).repeatForever(autoreverses: true).delay(2)) {
                        circle2Offset = CGSize(width: -120, height: 80)
                    }
                }

            // Third blurred circle
            Circle()
                .fill(Color.cyan.opacity(0.09))
                .frame(width: 350, height: 350)
                .offset(circle3Offset)
                .blur(radius: 90)
                .onAppear {
                    withAnimation(Animation.easeInOut(duration: 22).repeatForever(autoreverses: true).delay(4)) {
                        circle3Offset = CGSize(width: 80, height: 120)
                    }
                }

            // MARK: 2. Falling/Drifting Stars Layer

            ForEach(stars) { star in
                Image(systemName: "star.fill") // Using SF Symbol for a star
                    .font(.system(size: 8 + star.scale * 12)) // Varying size for depth
                    .foregroundColor(star.color) // Use the star's assigned color
                    .opacity(star.opacity)       // Apply current opacity
                    .offset(x: star.x, y: star.y) // Position the star
                    .rotationEffect(star.rotation) // Apply rotation
                    // Animations for smooth appearance/disappearance and movement
                    .animation(
                        .easeInOut(duration: star.isTwinkling ? Double.random(in: 1.0...2.5) : 0.8),
                        value: star.opacity // Animate opacity changes
                    )
                    .animation(.linear(duration: star.speed), value: star.y) // Animate vertical movement
            }
        }
        .onAppear(perform: setupSpaceStars) // Initialize stars when view appears
        .onReceive(timer) { _ in
            updateSpaceStars() // Update stars on timer tick
        }
    }

    // MARK: - Star Setup and Update Functions

    /// Initializes a starting set of stars when the view appears.
    private func setupSpaceStars() {
        for _ in 0..<100 { // Add a good number of initial stars
            addRandomSpaceStar()
        }
    }

    /// Creates and adds a new star with random properties to the stars array.
    private func addRandomSpaceStar() {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height

        // Random starting position (can be outside screen to drift in)
        let x = CGFloat.random(in: -screenWidth * 0.6 ... screenWidth * 0.6)
        let y = CGFloat.random(in: -screenHeight * 0.6 ... screenHeight * 0.6)

        let opacity = Double.random(in: 0.4...1.0) // Initial opacity
        let scale = Double.random(in: 0.3...1.2) // Size scale
        let rotation = Angle.degrees(Double.random(in: 0...360)) // Random initial rotation
        let speed = Double.random(in: 0.5...2.0) // Speed of drift

        // Randomly choose between a few star colors (yellow, white, light blue)
        let colors: [Color] = [.yellow, .white, Color(red: 0.8, green: 0.9, blue: 1.0)]
        let randomColor = colors.randomElement() ?? .yellow

        // Randomly determine if this star will have a twinkling effect
        let isTwinkling = Bool.random()

        stars.append(SpaceStar(x: x, y: y, opacity: opacity, scale: scale, rotation: rotation, speed: speed, color: randomColor, isTwinkling: isTwinkling))
    }

    /// Updates the position and properties of each star on every timer tick.
    private func updateSpaceStars() {
        var newStars: [SpaceStar] = []
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height

        for index in stars.indices {
            var star = stars[index]

            // Gentle downward and slight horizontal drift
            star.y += CGFloat(star.speed * 0.5) // Slower drift
            star.x += CGFloat(Double.random(in: -0.5...0.5)) // Slight horizontal movement

            // Apply twinkling or subtle fading effect
            if star.isTwinkling {
                star.opacity += Double.random(in: -0.01...0.01) // Small random change for twinkle
                star.opacity = max(0.2, min(1.0, star.opacity)) // Keep opacity within bounds
            } else {
                // For non-twinkling stars, a very subtle, slow fade/brighten
                if star.opacity <= 0.4 || star.opacity >= 0.9 {
                    star.opacity += (star.opacity <= 0.4 ? 0.005 : -0.005) // Reverse fade direction
                } else {
                    star.opacity += Double.random(in: -0.001...0.001) // Very subtle change
                }
                star.opacity = max(0.1, min(1.0, star.opacity)) // Keep within bounds
            }

            // If a star moves off-screen, reset its properties and position it back at the top/side
            if star.y > screenHeight / 2 + 100 || star.x > screenWidth / 2 + 100 || star.x < -screenWidth / 2 - 100 {
                star.x = CGFloat.random(in: -screenWidth * 0.6 ... screenWidth * 0.6)
                star.y = -screenHeight / 2 - 100 // Reset above screen
                star.opacity = Double.random(in: 0.4...1.0)
                star.scale = Double.random(in: 0.3...1.2)
                star.rotation = Angle.degrees(Double.random(in: 0...360))
                star.speed = Double.random(in: 0.5...2.0)
                let colors: [Color] = [.yellow, .white, Color(red: 0.8, green: 0.9, blue: 1.0)]
                star.color = colors.randomElement() ?? .yellow
                star.isTwinkling = Bool.random()
            }
            newStars.append(star)
        }
        stars = newStars // Update the state with the new star positions

        // Periodically add new stars to maintain density, but less frequently for a "static" field
        if Int.random(in: 0...20) == 0 { // Adjust this value to control frequency
            addRandomSpaceStar()
        }
    }
}

// MARK: - Preview Provider

/// Provides a preview of the SpaceThemeView in Xcode's canvas.
struct SpaceThemeView_Previews: PreviewProvider {
    static var previews: some View {
        SpaceThemeView()
    }
}
