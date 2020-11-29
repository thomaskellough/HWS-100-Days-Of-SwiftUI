//
//  AddNameView.swift
//  Milestone 13-15 NameToFace
//
//  Created by Thomas Kellough on 11/28/20.
//

import CoreData
import SwiftUI

struct AddNameView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    let locationFetcher = LocationFetcher()

    @Binding var image: Image?
    @Binding var uiImage: UIImage?
    @State private var name: String = ""
    
    var body: some View {
        VStack {
            if image != nil {
                VStack(alignment: .leading) {
                    image?
                        .resizable()
                        .scaledToFit()
                        .padding()
                    
                    Section(header: Text("Enter a name")) {
                        TextField("Name", text: $name)
                            .padding(4)
                            .border(Color.primary)
                    }
                    Spacer()
                }
                .padding()
            }
        }
        .onAppear(perform: fetchLocation)
        Button(action: {
            save()
        }, label: {
            Text("Save")
                .frame(width: 200, height: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
        })
    }
    
    func save() {
        let newPerson = Person(context: self.moc)
        newPerson.name = name
        newPerson.imageUrl = UUID()
        
        do {
            let completion = try convertImageToData(withFilename: newPerson.imageUrl!.uuidString)
            if completion {
                if let location = locationFetcher.lastKnownLocation {
                    newPerson.latitude = String(location.latitude)
                    newPerson.longitude = String(location.longitude)
                }
                
                if moc.hasChanges {
                    try? self.moc.save()
                }
            }
            
            self.presentationMode.wrappedValue.dismiss()
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func convertImageToData(withFilename filename: String) throws -> Bool {
        if let image = uiImage {
            if let jpegData = image.jpegData(compressionQuality: 0.8) {
                do {
                    let path = FileManager().documentDirectory.appendingPathComponent(filename)
                    try jpegData.write(to: path, options: [.atomicWrite, .completeFileProtection])
                    
                    return true
                } catch let error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
        
        return false
    }
    
    func fetchLocation() {
        self.locationFetcher.start()
    }
}

struct AddNameView_Previews: PreviewProvider {
    static var previews: some View {
        AddNameView(image: .constant(Image(systemName: "plus")), uiImage: .constant(UIImage(systemName: "plus")))
    }
}
