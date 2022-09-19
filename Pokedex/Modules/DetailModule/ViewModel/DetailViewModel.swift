//
//  DetailViewModel.swift
//  Pokedex
//
//  Created by Sem Koliesnikov on 19/09/2022.
//

import Foundation
import UIKit

class DetailViewModel: BaseViewNodel {
    
    let apiManager = DetailPokemonAPIManager()
    let detailAPIManager = DescriptionPokemonAPIManager()
    var extentionsColor = ExtentionsColor()
    var isFavorite: Bool?
    var isTeam: Bool?
    var detail: Pokemon.PokemonModel?
    var favoriteDetail: PokemonsSave?
    var teamDetail: PokemonsSave?
    var savePokemonCheck: [PokemonsSave] = []
    var pokemonInfo: DescriptionPokemon.DescriptionPokemonModel? {
        didSet {
            DispatchQueue.main.async { [self] in
                onReloadCollection?()
            }
        }
    }
    var pokemonDetail: DetailPokemon.DetailPokemonModel? {
        didSet {
            DispatchQueue.main.async { [self] in
                onReloadCollection?()
            }
        }
    }
    
    func fetchInformation(info: PokemonsSave?) {
        if info == nil {
            apiManager.fetchDetail(onCompletion: ({[weak self]
                currentPokemonData in self?.pokemonDetail = currentPokemonData }), forIdNumber: detail?.id ?? 1)
            
            detailAPIManager.fetchDescription(onCompletion: ({ [weak self]
                descriptionPokemon in self?.pokemonInfo = descriptionPokemon }), forIdNumber: detail?.id ?? 1)
            
            savePokemonCheck = StoringLocalPokemon.coreDataShared.fetchPokemons()
            
        } else {
            
            guard let number = Int(favoriteDetail?.number ?? "1") else { return }
            
            apiManager.fetchDetail(onCompletion: ({[weak self]
                currentPokemonData in self?.pokemonDetail = currentPokemonData }), forIdNumber: number)
            
            detailAPIManager.fetchDescription(onCompletion: ({ [weak self]
                descriptionPokemon in self?.pokemonInfo = descriptionPokemon }), forIdNumber: number)
        }
    }
    
    func seveToFavorite() {
        isFavorite = true
        let number = "\(detail?.id ?? 1)"
        StoringLocalPokemon.coreDataShared.saveNewPokemon(pokemon: detail!, number: number, status: isFavorite ?? true)
    }
    
    func deleteFavorite() {
        isFavorite = false
        var name: String?
        if (favoriteDetail?.name != nil) {
            name = favoriteDetail?.name
        } else {
            name = detail?.name
        }
        StoringLocalPokemon.coreDataShared.deleteFromData(name: name ?? "")
    }
}
