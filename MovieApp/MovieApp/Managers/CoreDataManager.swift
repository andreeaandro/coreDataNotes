import Foundation
import CoreData

class CoreDataManager {
    let persistentContainer: NSPersistentContainer

    static let shared = CoreDataManager()

    private init() {
        persistentContainer = NSPersistentContainer(name: "MovieAppModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Failed to initialize Core Data \(error)")
            }
        }
    }

    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    func getMovieById(_ id: NSManagedObjectID) -> Movie? {
        do {
            let movie = try viewContext.existingObject(with: id) as? Movie
            return movie
        } catch {
            print(error)
            return nil
        }
    }

    func deleteMovie(_ movie: Movie) {
        viewContext.delete(movie)
        
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print("Failed to delete movie \(error)")
        }
    }

    func getAllMovies() -> [Movie] {
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        
        do {
            return try viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }

    func save() {
        do {
            try viewContext.save()
        } catch {
            print("Failed to save a movie \(error)")
        }
    }
}
