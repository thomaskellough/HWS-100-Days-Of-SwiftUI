//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Thomas Kellough on 11/21/20.
//

import SwiftUI

struct ContentView: View {
    let students = [Student(name: "Harry Potter"), Student(name: "Hermione Granger")]
    var body: some View {
        List(students, id: \.self) { student in
            Text(student.name)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Student: Hashable {
    let name: String
}
