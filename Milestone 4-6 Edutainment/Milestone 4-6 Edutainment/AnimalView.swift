//
//  AnimalView.swift
//  Milestone 4-6 Edutainment
//
//  Created by Thomas Kellough on 8/31/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import Foundation
import SwiftUI

struct AnimalView: View {
    let animal: String
    var animalCount: Int
    
    var body: some View {
        HStack {
            ForEach(0 ..< animalCount) { _ in
                Image(self.animal)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
            }
        }
    }
}
