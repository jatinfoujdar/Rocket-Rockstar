import SwiftUI

struct AstronautDetailView: View {
    let astronaut: AstronautModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 5)

                Text(astronaut.name)
                    .font(.title)
                    .bold()

                Text(astronaut.description)
                    .font(.body)
            }
            .padding()
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
