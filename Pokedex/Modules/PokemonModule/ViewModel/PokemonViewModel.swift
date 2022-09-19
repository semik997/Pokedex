//
//  PokemonViewModel.swift
//  Pokedex
//
//  Created by Sem Koliesnikov on 19/09/2022.
//

import Foundation
import UIKit

class BaseViewNodel: NSObject {
    var onReloadCollection: (() -> Void)?
    var onShowHud: (() -> Void)?
    var onDismissHud: (() -> Void)?
}

class PokemonViewModel: BaseViewNodel {
    
    private var apiManager = ListOfPokemonAPIManager()
    var filtredPokemons: [Pokemon.PokemonModel] = []
    var teamPokemons: [Pokemon.PokemonModel] = []
    var pokemons: [Pokemon.PokemonModel] = [] {
        didSet {
            DispatchQueue.main.async { [self] in
                filtredPokemons = pokemons
                onReloadCollection?()
            }
        }
    }
    
    func fetchPokemons() {
        onShowHud?()
        apiManager.fetchPokemons(onCompletion: { [weak self] currentPokemonData in
            self?.onDismissHud?()
            self?.pokemons = currentPokemonData
        })
    }
    
}
