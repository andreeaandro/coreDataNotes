import SwiftUI

struct MovieDetail: View {
    let movie: Movie
    let coreDM: CoreDataManager
    @State private var movieName: String = ""
    @Binding var needsRefresh: Bool

    var body: some View {
        VStack {
            TextField(movie.title ?? "", text: $movieName)
            Button("Update") {
                if movieName != "" {
                    movie.title = movieName
                    coreDM.updateMovie()
                    needsRefresh.toggle()
                }
            }
        }
    }
}

struct MovieDetail_Previews: PreviewProvider {
    static var previews: some View {
        let coreDM = CoreDataManager()
        let movie = Movie(context: coreDM.persistentContainer.viewContext)
//        movie.title = "Lord of the Rings"
        
        MovieDetail(movie: movie, coreDM: coreDM, needsRefresh: .constant(false))
    }
}
