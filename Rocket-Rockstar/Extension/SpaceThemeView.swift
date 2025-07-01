import SwiftUI

struct Star: Identifiable {
    let id = UUID()
    let position: CGPoint
    let size: CGFloat
    let opacity: Double
}

struct SpaceThemeView: View {
    @State private var stars: [Star] = []
    
    var body: some View {
        ZStack {
            // Background gradient
            RadialGradient(gradient: Gradient(colors: [Color.black, Color.purple.opacity(0.4), Color.black]),
                           center: .center,
                           startRadius: 5,
                           endRadius: 500)
                .ignoresSafeArea()

            // Stars
            ForEach(stars) { star in
                Circle()
                    .fill(Color.white.opacity(star.opacity))
                    .frame(width: star.size, height: star.size)
                    .position(star.position)
                    .opacity(star.opacity)
                    .animation(
                        Animation.easeInOut(duration: Double.random(in: 2...5)).repeatForever(autoreverses: true),
                        value: star.id
                    )
            }
        }
        .onAppear {
            if stars.isEmpty {
                generateStars()
            }
        }
    }
    
    // Generates stable random stars on first appearance
    private func generateStars() {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height

        stars = (0..<100).map { _ in
            Star(
                position: CGPoint(x: CGFloat.random(in: 0...screenWidth),
                                  y: CGFloat.random(in: 0...screenHeight)),
                size: CGFloat.random(in: 1...3),
                opacity: Double.random(in: 0.2...0.8)
            )
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
