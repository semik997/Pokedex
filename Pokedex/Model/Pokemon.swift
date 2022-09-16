//
//  Pokemon.swift
//  Pokedex
//
//  Created by Sem Koliesnikov on 13/09/2022.
//

import Foundation
import CoreData

class Pokemon {
    
    static let shared = Pokemon()
    
    // MARK: - Data request structure via API
    
    struct PokemonModel: Codable {
        let id: Int
        let name: String
        let sprites: Sprites
        let types: [Types]?
    }
    
    struct Sprites: Codable {
        let front_default: String
    }
    
    struct Types: Codable {
        let type: `Type`?
    }

    struct `Type`: Codable {
        let name: String?
    }
    
}
