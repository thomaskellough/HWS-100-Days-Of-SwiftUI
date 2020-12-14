//
//  View+Extension.swift
//  Flashzilla
//
//  Created by Thomas Kellough on 12/14/20.
//

import Foundation
import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = CGFloat(total - position)
        return self.offset(CGSize(width: 0, height: offset * 10))
    }
}
