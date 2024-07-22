//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Galih Samudra on 19/07/24.
//

import SwiftUI

struct ContentView: View {
    @State private var counter = 0
    
    var body: some View {
        Button("Tap count \(counter)") {
            counter += 1
        }
        .sensoryFeedback(.increase, trigger: counter)
    }
}

#Preview {
    ContentView()
}
