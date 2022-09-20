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
    
    weak var delegate: PokemonProtokol?
    var extentionsColor = ExtensionColor()
    var color = ExtensionColor.TypesPokemon.bug
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellConfigure()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pokemonFirstAbilityLabel.text = nil
        pokemonSecondAbilityLabel.text = nil
        pokemonSecondAbilityLabel.backgroundColor = .white
    }
    
    // options shadow
    func cellConfigure() {
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
        // labelConfigure
        pokemonFirstAbilityLabel.layer.masksToBounds = true
        pokemonFirstAbilityLabel.layer.cornerRadius = 10
        pokemonSecondAbilityLabel.layer.masksToBounds = true
        pokemonSecondAbilityLabel.layer.cornerRadius = 10
    }
    
    // Load cell content
    func loadConfigure(pokemon: Pokemon.PokemonModel) {
        let imageURL = URL(string: pokemon.sprites.front_default)
        pokemonNameLabel.text = pokemon.name.capitalized
        pokemonIdLabel.text = "No. \(pokemon.id)"
        pokemonImage.sd_setImage(with: imageURL)
        let firstAbilityName = pokemon.types?[0].type?.name
        pokemonFirstAbilityLabel.backgroundColor = extentionsColor.typeColor(name: firstAbilityName ?? "grass")
        pokemonFirstAbilityLabel.text = pokemon.types?[0].type?.name
        // Сheck for the presence of the 2nd ability
        for i in 1 ..< (pokemon.types?.count ?? 1) {
            if pokemonSecondAbilityLabel != nil {
                pokemonSecondAbilityLabel.text = pokemon.types?[i].type?.name
                let secondAbilityName = pokemon.types?[i].type?.name
                pokemonSecondAbilityLabel.backgroundColor = extentionsColor.typeColor(name: secondAbilityName ?? "grass")
            }
        }
    }
}
