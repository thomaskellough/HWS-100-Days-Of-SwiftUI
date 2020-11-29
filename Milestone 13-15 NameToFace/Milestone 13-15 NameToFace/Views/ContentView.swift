//
//  ContentView.swift
//  Milestone 13-15 NameToFace
//
//  Created by Thomas Kellough on 11/28/20.
//

import SwiftUI

enum ActiveSheet {
    case addingPhoto, addingName
}

struct ContentView: View {
    // MARK: Core Data properties
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Person.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Person.name, ascending: true),
    ]) var people: FetchedResults<Person>
    
    // MARK: Image Picker properties
//    @State private var showingImagePicker = false
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    
    @State private var activeSheet = ActiveSheet.addingPhoto
    @State private var showingSheet = false
//    @State private var showingAddNameView = false
    
    var body: some View {
        NavigationView {
            VStack {
                if people.count > 0 {
                    List(people) { person in
                        Text(person.unwrappedName)
                    }
                } else {
                    Text("No people added. Please select the '+' button at the top rigth to add your first person.")
                        .padding()
                        .font(.headline)
                }
            }
            .navigationBarTitle("Name to Face")
            .navigationBarItems(trailing:
                Button(action: {
                    self.inputImage = nil
                    self.showingSheet = true
                }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $showingSheet, onDismiss: addName) {
                switch self.activeSheet {
                case .addingPhoto:
                    ImagePicker(image: self.$inputImage)
                case .addingName:
                    AddNameView(image: self.$image, uiImage: self.$inputImage)
                }
            }
        }
    }
    
    func addName() {
        if inputImage != nil {
            image = Image(uiImage: inputImage!)
        }
        
        if self.activeSheet == .addingPhoto && inputImage != nil {
            self.showingSheet = true
            self.activeSheet = .addingName
        } else {
            self.showingSheet = false
            self.activeSheet = .addingPhoto
            saveImage()
        }
    }
    
    func saveImage() {
        // save image to core data
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

