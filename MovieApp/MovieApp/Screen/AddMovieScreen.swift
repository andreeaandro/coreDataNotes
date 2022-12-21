import SwiftUI

struct AddMovieScreen: View {
    @StateObject private var addMovieVM = AddMovieViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Enter name", text: $addMovieVM.title)
                TextField("Enter director", text: $addMovieVM.director)
                HStack {
                    Text("Rating")
                    Spacer()
                    RatingView(rating: $addMovieVM.rating)
                }
                DatePicker("Release Date", selection: $addMovieVM.releaseDate)
                
                HStack {
                    Spacer()
                    Button("Save") {
                        addMovieVM.save()
                        presentationMode.wrappedValue.dismiss()
                    }
                    Spacer()
                }
            }
            .navigationTitle("Add Movie")
        }
    }
}

struct AddMovieScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddMovieScreen()
    }
}