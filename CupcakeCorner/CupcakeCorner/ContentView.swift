//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Galih Samudra on 19/07/24.
//

import SwiftUI

struct ContentView: View {
    @State private var results: [Result] = []
    
    var body: some View {
        VStack {
            AsyncImage(url:  URL(string: "https://hws.dev/img/logo.png"), scale: 3) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            } placeholder: {
                ProgressView()
            }
            List(results, id: \.trackId) { item in
                VStack(alignment: .leading, content: {
                    Text(item.trackName)
                        .font(.headline)
                    Text(item.collectionName)
                })
            }
            .task {
                await loadData()
            }
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("invalid URL")
            return
        }
        do {
            let (data, metaData) = try await URLSession.shared.data(from: url)
            print("meta data: \(metaData.debugDescription)")
            
            if let decodeResponse = try? JSONDecoder().decode(Response.self, from: data) {
                print("results: \(decodeResponse)")
                results = decodeResponse.results
            }
        } catch {
            print("invalid data - \(error.localizedDescription)")
        }
        
    }
}

#Preview {
    ContentView()
}
