import SwiftUI

struct MovieListScreen: View {
    @StateObject private var movieListVM = MovieListViewModel()
    @State private var isPresented: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(movieListVM.movies, id: \.id) { movie in
                    MovieCell(movie: movie)
                }
                .onDelete(perform: deleteMovie)
            }
            .navigationTitle("Movies")
            .navigationBarItems(trailing: Button("Add movie", action: {
                isPresented = true
            }))
            .sheet(isPresented: $isPresented, onDismiss: {
                movieListVM.getAllMovies()
            }, content: {
                AddMovieScreen()
            })
        }
        .onAppear() {
            movieListVM.getAllMovies()
        }
    }
    
    func deleteMovie(indexSet: IndexSet) {
        indexSet.forEach { index in
            let movie = movieListVM.movies[index]
            movieListVM.deleteMovie(movie: movie)
            movieListVM.getAllMovies()
        }
    }
}

struct MovieCell: View {
    let movie: MovieViewModel
    
    var body: some View {
        HStack {
            VStack {
                Text(movie.title)
                    .fontWeight(.bold)
                Text(movie.director)
                    .font(.caption2)
                Text(movie.releaseDate ?? "")
                    .font(.caption)
            }
            Spacer()
            RatingView(rating: .constant(movie.rating))
        }
    }
}

struct MovieListScreen_Previews: PreviewProvider {
    static var previews: some View {
        MovieListScreen()
    }
}
