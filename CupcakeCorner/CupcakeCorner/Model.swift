//
//  Model.swift
//  CupcakeCorner
//
//  Created by Galih Samudra on 19/07/24.
//

import Foundation

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct Response: Codable {
    var results: [Result]
}

@Observable
class User: Codable {
    enum CodingKeys: String, CodingKey {
        case _name = "name"
    }
    var name = "Taylor"
}
