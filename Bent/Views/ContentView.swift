//
//  ContentView.swift
//  Bent
//
//  Created by Northstar✨System on 2023-05-18.
//

import SwiftUI

struct ContentView: View {
    
    let appSection: AppSection
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
