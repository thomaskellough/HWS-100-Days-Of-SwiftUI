//
//  ContentView.swift
//  BucketList
//
//  Created by Thomas Kellough on 11/27/20.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        MapView()
            .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
