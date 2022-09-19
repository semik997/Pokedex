//
//  Constants.swift
//  Pokedex
//
//  Created by Sem Koliesnikov on 14/09/2022.
//

import Foundation
import UIKit

class Constants {
    // MARK: - API link
    
    static let listOfPokemonLinkAPI = "https://stoplight.io/mocks/appwise-be/pokemon/57519009/pokemon"
    static let detailPokemonLinkAPI = "https://pokeapi.co/api/v2/pokemon/"
    static let descriptionPokemonLinkAPI = "https://pokeapi.co/api/v2/pokemon-species/"
    
    // MARK: - Constants from Segue
    struct SeguesConst {
        static let showTeam = "showTeam"
        static let showFavorite = "showFavorite"
        static let showDetail = "showDetail"
    }
}
