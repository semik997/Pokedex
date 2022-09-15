//
//  PokemonViewCell.swift
//  Pokedex
//
//  Created by Sem Koliesnikov on 13/09/2022.
//

import UIKit
import SDWebImage

protocol PokemonProtokol: AnyObject {
    func selectCell(_id: Int, name: String, imgage: String)
}

class PokemonViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonIdLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonFirstAbilityLabel: UILabel!
    @IBOutlet weak var pokemonSecondAbilityLabel: UILabel!
    
    
    
    private var currentPokemon: Pokemon.PokemonModel?
    weak var delegate: PokemonProtokol?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        
    }

}

extension PokemonViewCell {
    
    func loadData(pokemon: Pokemon.PokemonModel) {
        let imageURL = URL(string: pokemon.sprites.front_default)
        currentPokemon = pokemon
        pokemonNameLabel.text = pokemon.name
        pokemonIdLabel.text = "Nr. \(pokemon.id)"
        pokemonImage.sd_setImage(with: imageURL)
    }
    
}
