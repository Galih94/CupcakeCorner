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
                .accessibilityElement()
        } placeholder: {
            ProgressView()
                .accessibilityElement()
        }
    }
}

struct CheckoutView: View {
    var order: Order
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var isError = false
    var body: some View {
        ScrollView {
            VStack {
                CustomImageView(urlString: "https://hws.dev/img/cupcakes@3x.jpg")
                    .frame(height: 233)
                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                Button("Place Order") {
                    Task {
                        await placeOrer()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check Out")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isError ? "Error" :"Thank you!", isPresented: $showingConfirmation, actions: {
            Button("OK") {
                showingConfirmation = false
            }
        }, message: {
            Text(confirmationMessage)
        })
        .scrollBounceBehavior(.basedOnSize)
    }
    
    private func placeOrer() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Error encode order")
            return
        }
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodeOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodeOrder.quantity) \(Order.types[decodeOrder.type]) cup cakes"
            isError = false
            showingConfirmation = true
        } catch {
            print("Error checkout - \(error.localizedDescription)")
            confirmationMessage = "Error checkout - \(error.localizedDescription)"
            isError = true
            showingConfirmation = true
            
        }
    }
}

#Preview {
    CheckoutView(order: Order())
}
