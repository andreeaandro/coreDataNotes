//
//  ReviewListScreen.swift
//  MovieApp
//
//  Created by Andreea A on 17.12.2022.
//

import SwiftUI

struct ReviewListScreen: View {
    let movie: MovieViewModel
    @StateObject private var reviewListVM = ReviewListViewModel()
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("Reviews")) {
                    ForEach(reviewListVM.reviews, id: \.reviewId) { review in
                        VStack {
                            Text(review.title)
                            Text(review.text)
                        }
                    }
                }
                
            }
        }
    }
}

struct ReviewListScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            let movie = Movie(context: CoreDataManager.shared.viewContext)
            ReviewListScreen(movie: MovieViewModel(movie: movie))
        }
    }
}
