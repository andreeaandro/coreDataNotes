import Foundation
import CoreData

class ReviewListViewModel: ObservableObject {
    @Published var reviews: [ReviewViewModel] = []
    
    func getReviewsByMovie(vm: MovieViewModel) {
        
    }
}

struct ReviewViewModel {
    let reviewId = 2
    let title = "Title"
    let text = "Text"
    let publishedDate = Date() 
}
