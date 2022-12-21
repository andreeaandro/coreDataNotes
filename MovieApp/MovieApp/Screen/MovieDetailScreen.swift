//
//  MovieDetailScreen.swift
//  MovieApp
//
//  Created by Andreea A on 17.12.2022.
//

import SwiftUI

struct MovieDetailScreen: View {
    let movie: MovieViewModel
    
    var body: some View {
        Text("Hello, World!")
            .navigationTitle(movie.title)
    }
}

struct MovieDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            let movie = Movie(context: CoreDataManager.shared.viewContext)
            
            MovieDetailScreen(movie: MovieViewModel(movie: movie))
        }
    }
}
