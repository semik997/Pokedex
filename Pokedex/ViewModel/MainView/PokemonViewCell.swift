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
    
//    private var currentPokemon: Pokemon.PokemonModel?
    weak var delegate: PokemonProtokol?
    var extentionsColor = ExtentionsColor()
    var color = ExtentionsColor.TypesPokemon.bug
    var firstAbilityName: String?
    var secondAbilityName: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellOptions()
        labelOptions()
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
    
    func labelOptions() {
        pokemonFirstAbilityLabel.layer.masksToBounds = true
        pokemonFirstAbilityLabel.layer.cornerRadius = 10
        pokemonSecondAbilityLabel.layer.masksToBounds = true
        pokemonSecondAbilityLabel.layer.cornerRadius = 10
    }
    
    // Load data in cell
    func loadData(pokemon: Pokemon.PokemonModel) {
        let imageURL = URL(string: pokemon.sprites.front_default)
//        currentPokemon = pokemon
        pokemonNameLabel.text = pokemon.name
        pokemonIdLabel.text = "Nr. \(pokemon.id)"
        pokemonImage.sd_setImage(with: imageURL)
        firstAbilityName = pokemon.types?[0].type?.name
        pokemonFirstAbilityLabel.backgroundColor = extentionsColor.typeColor(name: firstAbilityName ?? "grass")
        pokemonFirstAbilityLabel.text = pokemon.types?[0].type?.name
        // Сheck for the presence of the 2nd ability
        for i in 1 ..< (pokemon.types?.count ?? 1) {
            if pokemonSecondAbilityLabel != nil {
                pokemonSecondAbilityLabel.text = pokemon.types?[i].type?.name
                secondAbilityName = pokemon.types?[i].type?.name
                pokemonSecondAbilityLabel.backgroundColor = extentionsColor.typeColor(name: secondAbilityName ?? "grass")
            }
        }
    }
}
