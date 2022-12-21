import Foundation
import CoreData

class MovieListViewModel: ObservableObject {
    @Published var movies: [MovieViewModel] = []
    
    func deleteMovie(movie: MovieViewModel) {
        let movie = CoreDataManager.shared.getMovieById(movie.id)
        if let movie = movie {
            CoreDataManager.shared.deleteMovie(movie)
        }
    }
    
    func getAllMovies() {
        let movies = CoreDataManager.shared.getAllMovies()
        
        DispatchQueue.main.async {
            self.movies = movies.map({ movie in
                MovieViewModel(movie: movie)
            })
        }
    }
}

struct MovieViewModel {
    let movie: Movie
    
    var id: NSManagedObjectID {
        movie.objectID
    }
    var title: String {
        movie.title ?? ""
    }
    var director: String {
        movie.director ?? "Not available"
    }
    var releaseDate: String? {
        movie.releaseDate?.asFormattedString()
    }
    var rating: Int? {
        Int(movie.rating)
    }
}
