//
//  ContentView.swift
//  HotProspects
//
//  Created by Thomas Kellough on 11/29/20.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        VStack {
            Image("example")
                .interpolation(.none)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: .infinity)
                .background(Color.black)
                .edgesIgnoringSafeArea(.all)
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
