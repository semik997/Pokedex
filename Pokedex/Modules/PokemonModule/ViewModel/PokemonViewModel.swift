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
    var menuItems: [UIAction] {
        return [
            UIAction(title: "Alphabetically ascending", image: UIImage(systemName: "arrow.up"), handler: { action in
                self.filtredPokemons = self.pokemons.sorted { $0.name.localizedCaseInsensitiveCompare($1.name)  == ComparisonResult.orderedAscending }
                self.onReloadCollection?()
            }),
            UIAction(title: "Alphabetically descending", image: UIImage(systemName: "arrow.down"), handler: { action in
                let sorted = self.pokemons.sorted { $0.name.localizedCaseInsensitiveCompare($1.name)  == ComparisonResult.orderedAscending }
                self.filtredPokemons = Array(sorted.reversed())
                self.onReloadCollection?()
            }),
            UIAction(title: "Numerically ascending", image: UIImage(systemName: "arrow.up"), handler: { action in
                self.filtredPokemons = self.pokemons.sorted(by: {($0.id > $1.id)})
                self.onReloadCollection?()
            }),
            UIAction(title: "Numerically descending", image: UIImage(systemName: "arrow.down"), handler: { action in
                self.filtredPokemons = self.pokemons.sorted(by: {($0.id < $1.id)})
                self.onReloadCollection?()
            })
        ]
    }
    var demoMenu: UIMenu {
        return UIMenu(title: "Sort by", image: nil, identifier: nil, options: [], children: menuItems)
    }
    
}
