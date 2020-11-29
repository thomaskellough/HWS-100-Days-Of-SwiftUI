//
//  DetailView.swift
//  Milestone 13-15 NameToFace
//
//  Created by Thomas Kellough on 11/28/20.
//

import SwiftUI

struct DetailView: View {
    var image: Image?
    
    var body: some View {
        if image != nil {
            image!
                .resizable()
                .scaledToFit()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(image: Image(systemName: "plus"))
    }
}
