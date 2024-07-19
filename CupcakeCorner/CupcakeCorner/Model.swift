//
//  Model.swift
//  CupcakeCorner
//
//  Created by Galih Samudra on 19/07/24.
//

import Foundation

struct Result: Codable {
    var trackedId: Int
    var trackName: String
    var collectionName: String
}

struct Response: Codable {
    var results: [Result]
}
