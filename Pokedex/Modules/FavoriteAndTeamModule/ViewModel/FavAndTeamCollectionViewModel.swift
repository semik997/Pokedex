//
//  FavAndTeamCollectionViewModel.swift
//  Pokedex
//
//  Created by Sem Koliesnikov on 19/09/2022.
//

import Foundation
import UIKit

class FavAndTeamCollectionViewModel: BaseViewNodel {
    
    var isFavorite: Bool?
    var teamDetail: [PokemonsSave] = [] {
        didSet {
            DispatchQueue.main.async { [self] in
                onReloadCollection?()
            }
        }
    }
    var favoritePokemons: [PokemonsSave] = [] {
        didSet {
            DispatchQueue.main.async { [self] in
                onReloadCollection?()
                
            }
        }
    }
    
    func uploadPokemons() {
        favoritePokemons = StoringLocalPokemon.coreDataShared.fetchPokemons()
    }
}
