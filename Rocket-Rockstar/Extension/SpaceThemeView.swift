import SwiftUI

// MARK: - ContentView
// This is the main view of the app, showcasing the space theme.
struct SpaceThemeView: View {
    // State variable to control the scale of the "planet" for animation.
    @State private var planetScale: CGFloat = 1.0
    // State variable to control the rotation of a "star" for animation.
    @State private var starRotation: Double = 0.0

    var body: some View {
        ZStack {
            // MARK: - Background Layer
            // A deep space background with a radial gradient.
            RadialGradient(gradient: Gradient(colors: [Color.black, Color.purple.opacity(0.4), Color.black]),
                           center: .center,
                           startRadius: 5,
                           endRadius: 500)
                .ignoresSafeArea() // Extends the gradient to the edges of the screen.

            // MARK: - Stars Layer
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

// MARK: - Preview Provider
// Provides a preview of the ContentView in Xcode's canvas.
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SpaceThemeView()
    }
}
