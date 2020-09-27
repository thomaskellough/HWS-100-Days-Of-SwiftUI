//
//  AddActivityView.swift
//  Milestone 7-9 HabitTracker
//
//  Created by Thomas Kellough on 9/21/20.
//

import SwiftUI

struct AddActivityView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var activityName = ""
    @State private var activityCount = ""
    @State private var activityDescription = ""
    
    @State private var showingInvalidCountAlert = false
    
    @ObservedObject var activities: Activities
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Activity Name", text: $activityName)
                    TextField("Description", text: $activityDescription)
                    TextField("Number practiced", text: $activityCount)
                        .keyboardType(.numberPad)
                }
                .alert(isPresented: $showingInvalidCountAlert) {
                    Alert(title: Text("Error"), message: Text("Please enter an integer only"), dismissButton: .default(Text("Okay")))
                }
            }
            .navigationBarTitle("Add a new activity")
            .navigationBarItems(
                trailing:
                    Button("Save") {
                        self.save()
                    }
            )
        }
    }
    
    func save() {
        if let count = Int(self.activityCount) {
            let activity = Activity(name: self.activityName, description: self.activityDescription, count: count)
            self.activities.activities.append(activity)
            self.presentationMode.wrappedValue.dismiss()
        } else {
            self.showingInvalidCountAlert.toggle()
        }
    }
    
}

struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityView(activities: Activities())
    }
}
