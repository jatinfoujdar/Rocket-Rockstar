import SwiftUI


struct AstronautDetailView: View {
    let astronaut: AstronautModel

    var body: some View {
        ZStack {
            // Cosmic background
            LinearGradient(
                colors: [Color.black, Color.purple.opacity(0.8), Color.blue.opacity(0.6)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 30) {
                    // Astronaut Image
                    Image(astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(LinearGradient(colors: [.cyan, .purple, .blue], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 6)
                        )
                        .shadow(color: .cyan.opacity(0.9), radius: 20)

                    // Astronaut Name
                    Text(astronaut.name)
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                        .shadow(color: .purple, radius: 10)

                    // Description
                    Text(astronaut.description)
                        .font(.body)
                        .foregroundColor(.white.opacity(0.85))
                        .multilineTextAlignment(.leading)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white.opacity(0.05))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(LinearGradient(colors: [.pink, .purple], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 2)
                                )
                                .shadow(color: .blue.opacity(0.5), radius: 15)
                        )
                        .padding(.horizontal)
                }
                .padding(.top, 50)
                .padding(.bottom, 100)
            }
        }
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    let sampleAstronaut = AstronautModel(
        id: "armstrong",
        name: "Neil Armstrong",
        description: "First man to walk on the Moon during the Apollo 11 mission in 1969."
    )

    AstronautDetailView(astronaut: sampleAstronaut)
}
