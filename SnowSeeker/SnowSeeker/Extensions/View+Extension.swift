//
//  View+Extension.swift
//  SnowSeeker
//
//  Created by Thomas Kellough on 12/18/20.
//

import SwiftUI

extension View {
    func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        } else {
            return AnyView(self)
        }
    }
}
