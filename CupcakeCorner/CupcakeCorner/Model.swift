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

struct Address: Identifiable, Codable {
    var id = UUID()
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
}

let key = "key"

@Observable
class Order: Codable {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _address = "address"
    }
    
    init() {
        if let savedData = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode(Address.self, from: savedData) {
            self.address = decoded
        }
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if !specialRequestEnabled {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var address: Address = Address() {
        didSet {
            if let data = try? JSONEncoder().encode(address) {
                UserDefaults.standard.setValue(data, forKey: key)
            }
        }
    }
    
    var hasValidAddress: Bool {
        if address.name.isEmpty || address.streetAddress.isEmpty || address.city.isEmpty || address.zip.isEmpty ||
            address.name.trimmingCharacters(in: .whitespaces).isEmpty ||
            address.streetAddress.trimmingCharacters(in: .whitespaces).isEmpty ||
            address.city.trimmingCharacters(in: .whitespaces).isEmpty ||
            address.zip.trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        }
        return true
    }
    
    var cost: Decimal {
        /// $2 per cake
        var cost = Decimal(quantity) * 2
        
        /// complicated cakes cost more
        cost += Decimal(type) * 2
        
        /// $1 per cake for extra frosting
        if extraFrosting {
            cost += Decimal(quantity)
        }
        
        /// $0.50 per cake for sprinkles
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        
        return cost
    }
}
