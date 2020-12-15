//
//  VerticalAlignment+Extension.swift
//  LayoutAndGeometry
//
//  Created by Thomas Kellough on 12/15/20.
//

import SwiftUI

extension VerticalAlignment {
    enum MidAccountAndName: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.top]
        }
    }
    
    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}
