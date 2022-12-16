import SwiftUI

struct ContentView: View {
    let coreDM: CoreDataManager
    @State private var movieName: String = ""
    @State private var movies: [Movie] = []
    @State private var needsRefresh: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter movie name", text: $movieName)
                Button("Save") {
                    coreDM.saveMovie(title: movieName)
                    movies = coreDM.getAllMovies()
                }
                List {
                    ForEach(movies, id: \.self) { movie in
                        NavigationLink(
                            destination: MovieDetail(
                                movie: movie,
                                coreDM: coreDM,
                                needsRefresh: $needsRefresh
                            ),
                            label: {
                                Text(movie.title ?? "")
                            }
                        )
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            let movie = movies[index]
                            coreDM.deleteMovie(movie)
                            movies = coreDM.getAllMovies()
                        }
                    }
                }
                .accentColor(needsRefresh ? .white : .blue)
                Spacer()
            }
            .padding()
            .onAppear {
                movies = coreDM.getAllMovies()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coreDM: CoreDataManager())
    }
}
