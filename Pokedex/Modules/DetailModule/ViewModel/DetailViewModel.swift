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
