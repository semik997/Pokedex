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
        cellOptions()
    }
    
    func cellOptions() {
        // options shadow
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 15)
        layer.shadowRadius = 15
        layer.shadowOpacity = 1
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        layer.backgroundColor = UIColor.white.cgColor
        // options cell
        contentView.layer.masksToBounds = true
        layer.cornerRadius = 10
    }
    // Load data in cell
    func loadData(pokemon: Pokemon.PokemonModel) {
        let imageURL = URL(string: pokemon.sprites.front_default)
        currentPokemon = pokemon
        pokemonNameLabel.text = pokemon.name
        pokemonIdLabel.text = "Nr. \(pokemon.id)"
        pokemonImage.sd_setImage(with: imageURL)
    }
    
}
