//
//  Animations.swift
//  GuessTheFlag
//
//  Created by Thomas Kellough on 8/26/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import Foundation
import SwiftUI

struct Animations: ViewModifier {
    var amount: Double
    
    func body(content: Content) -> some View {
        content.rotation3DEffect(.degrees(amount), axis: (x: 0, y: 1, z: 0))
    }
}

