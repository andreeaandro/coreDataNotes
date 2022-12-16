import Foundation
import CoreData

class CoreDataManager {
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "HelloCoreDataModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data Store failed to initialize \(error.localizedDescription)")
            }
        }
    }
    
    func saveMovie(title: String) {
        let entity = Movie(context: persistentContainer.viewContext)
        entity.title = title
        
        do {
            try persistentContainer.viewContext.save()
            print("Movie \(title) saved")
        } catch {
            print("Failed to save the movie \(error)")
            persistentContainer.viewContext.rollback()
        }
    }
    
    func getAllMovies() -> [Movie] {
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func deleteMovie(_ movie: Movie) {
        persistentContainer.viewContext.delete(movie)
        do {
            try persistentContainer.viewContext.save()
            print("Movie deleted")
        } catch {
            print("Failed to delete the movie \(error)")
            persistentContainer.viewContext.rollback()
        }
    }
    
    func updateMovie() {
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Failed to update the movie")
            persistentContainer.viewContext.rollback()
        }
    }
}
