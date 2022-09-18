//
//  DetailPokemon.swift
//  Pokedex
//
//  Created by Sem Koliesnikov on 17/09/2022.
//

import Foundation
import UIKit

class DetailPokemon {
    
    static let sharedDetail = DetailPokemon()

    // MARK: - Data request structure via API from https://pokeapi.co/api/v2/pokemon/
    
    struct DetailPokemonModel: Codable {
        let base_experience: Float
        let height: Int
        let moves: [Moves]
        let sprites: Sprites?
        let stats: [Stats]?
        let weight: Int
    }
    
    struct Moves: Codable {
        let move: Name
    }
    
    struct Name: Codable {
        let name: String
    }
    
    struct Sprites: Codable {
        let other: Other?
    }

    struct Other: Codable {
        let image: Image?
        
        enum CodingKeys: String, CodingKey {
            case image = "official-artwork"
        }
    }

    struct Image: Codable {
        let front_default: String
    }

    struct Stats: Codable {
        let base_stat: Float

    }
    
    
}
