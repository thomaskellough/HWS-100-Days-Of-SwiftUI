//
//  CustomViewModifiers.swift
//  Milestone 7-9 HabitTracker
//
//  Created by Thomas Kellough on 9/27/20.
//

import Foundation
import SwiftUI

struct ButtonViewModifer: ViewModifier {
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .frame(width: 96, height: 96)
            .font(.title)
            .foregroundColor(.white)
            .background(color)
            .cornerRadius(10.0)
    }
}
