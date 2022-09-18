//
//  DescriptionPokemon.swift
//  Pokedex
//
//  Created by Sem Koliesnikov on 18/09/2022.
//

import Foundation
import UIKit

class DescriptionPokemon {
    
    static let descriptionShared = DescriptionPokemon()
    
    // MARK: - Data request structure via API from https://pokeapi.co/api/v2/pokemon-species/
    
    struct DescriptionPokemonModel: Codable {
        let info: [Info]
        enum CodingKeys: String, CodingKey {
            case info = "flavor_text_entries"
        }
    }
    
    struct Info: Codable {
        let descriptionText: String
        
        enum CodingKeys: String, CodingKey {
            case descriptionText = "flavor_text"
        }
    }
    
    
    
}
