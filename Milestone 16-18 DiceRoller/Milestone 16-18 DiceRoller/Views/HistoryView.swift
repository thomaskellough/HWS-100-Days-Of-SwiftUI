//
//  HistoryView.swift
//  Milestone 16-18 DiceRoller
//
//  Created by Thomas Kellough on 12/16/20.
//

import SwiftUI

struct HistoryView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Roll.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Roll.date, ascending: false),
    ]) var rolls: FetchedResults<Roll>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(rolls, id: \.self) { roll in
                    VStack(alignment: .leading) {
                        Text("Dice: \(roll.rollsArrayString)")
                            .font(.title3)
                        Text("Total: \(roll.total)")
                            .font(.headline)
                    }
                }
            }
            .navigationBarTitle("History")
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
