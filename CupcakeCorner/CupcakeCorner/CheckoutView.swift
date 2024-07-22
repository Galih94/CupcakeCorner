//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Galih Samudra on 22/07/24.
//

import SwiftUI

struct CustomImageView: View {
    let urlString: String
    var body: some View {
        AsyncImage(url: URL(string: urlString),scale: 3) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            ProgressView()
        }
    }
}

struct CheckoutView: View {
    var order: Order
    var body: some View {
        ScrollView {
            VStack {
                CustomImageView(urlString: "https://hws.dev/img/cupcakes@3x.jpg")
                    .frame(height: 233)
                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                Button("Place Order") {
                    
                }
                .padding()
            }
        }
        .navigationTitle("Check Out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
    }
}

#Preview {
    CheckoutView(order: Order())
}
