//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Galih Samudra on 19/07/24.
//

import SwiftUI

struct ContentView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $name)
                TextField("Email", text: $email)
            }
            Section {
                Button("Confirm") {
                    print("Confimation process...")
                }
            }
            .disabled(name.isEmpty || email.isEmpty)
        }
    }
}

#Preview {
    ContentView()
}
