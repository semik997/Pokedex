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

    // MARK: - Data request structure via API
    
    struct DetailPokemonModel: Codable {
        let base_experience: Int
        let height: Int
        let sprites: Sprites?
        let stats: [Stats]?
        let weight: Int
    }
    
    struct Sprites: Codable {
        let other: Other?
    }

    struct Other: Codable {
        let dream_world: Dream_world?
    }

    struct Dream_world: Codable {
        let front_default: String
    }

    struct Stats: Codable {
        let base_stat: Int

    }
}
