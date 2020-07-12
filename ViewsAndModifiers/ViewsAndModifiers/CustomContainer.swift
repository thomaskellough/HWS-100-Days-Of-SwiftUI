//
//  CustomContainer.swift
//  ViewsAndModifiers
//
//  Created by Thomas Kellough on 7/12/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import SwiftUI

struct CustomerContainerView: View {
    
    var body: some View {
        GridStack(rows: 4, columns: 4) { row, col in
            HStack {
                Image(systemName: "\(row * 4 + col).circle")
                Text("R\(row) C\(col)")
            }
        }
    }
}

struct CustomerContainerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomerContainerView()
    }
}

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) {
                row in HStack {
                    ForEach(0..<self.columns, id: \.self) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }
}
