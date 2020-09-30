//
//  ContentView.swift
//  Bookworm
//
//  Created by Lucas Lee on 9/29/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @FetchRequest(entity: Book.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Book.title, ascending: true),
        NSSortDescriptor(keyPath: \Book.author, ascending: true)
    ]) var books: FetchedResults<Book>

    @State private var showingAddScreen = false
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            // find this book in our fetch request
            let book = books[offset]

            // delete it from the context
            moc.delete(book)
        }

        // save the context
        try? moc.save()
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books, id: \.self) { book in
                    NavigationLink(destination: DetailView(book: book)) {
                        EmojiRatingView(rating: book.rating)
                            .font(.largeTitle)

                        VStack(alignment: .leading) {
                            Text(book.title ?? "Unknown Title")
                                .font(.headline)
                                .foregroundColor(book.rating <= 1 ? .red : .black)
                            Text(book.author ?? "Unknown Author")
                                .foregroundColor(.secondary)
                        }
                    }
                }.onDelete(perform: deleteBooks)
            }
           .navigationBarTitle("Bookworm")
           .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                self.showingAddScreen.toggle()
                self.presentationMode.wrappedValue.dismiss()
           }) {
               Image(systemName: "plus")
           })
           .sheet(isPresented: $showingAddScreen) {
               AddBookView().environment(\.managedObjectContext, self.moc)
           }
       }
    }

   
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
