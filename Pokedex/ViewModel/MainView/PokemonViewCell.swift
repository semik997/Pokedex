//
//  PokemonViewCell.swift
//  Pokedex
//
//  Created by Sem Koliesnikov on 13/09/2022.
//

import UIKit
import SDWebImage
//import QuartzCore

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
    var color = TypesPokemon.bug
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
//        pokemonFirstAbilityLabel.backgroundColor = UIColor(red: 0.729, green: 0.494, blue: 0.784, alpha: 1)
        pokemonSecondAbilityLabel.layer.masksToBounds = true
        pokemonSecondAbilityLabel.layer.cornerRadius = 10
//        pokemonSecondAbilityLabel.backgroundColor = UIColor(red: 0.584, green: 0.761, blue: 0.302, alpha: 1)
    }
    
    // Load data in cell
    func loadData(pokemon: Pokemon.PokemonModel) {
        var checkSecondAbility = false
        let imageURL = URL(string: pokemon.sprites.front_default)
        currentPokemon = pokemon
        pokemonNameLabel.text = pokemon.name
        pokemonIdLabel.text = "Nr. \(pokemon.id)"
        pokemonImage.sd_setImage(with: imageURL)
        firstAbilityName = pokemon.types?[0].type?.name
        firstTypeColor()
        pokemonFirstAbilityLabel.text = pokemon.types?[0].type?.name
        // Сheck for the presence of the 2nd ability
        for i in 1 ..< pokemon.types!.count {
            pokemonSecondAbilityLabel.text = pokemon.types?[i].type?.name
            secondAbilityName = pokemon.types?[i].type?.name
            secondTypeColor()
            checkSecondAbility = true
        }
        if checkSecondAbility == false {
            pokemonSecondAbilityLabel.isHidden = true
        }
    }
    
    func firstTypeColor() {
        switch firstAbilityName {
        case "grass":
            pokemonFirstAbilityLabel.backgroundColor = UIColor(red: 0.584, green: 0.761, blue: 0.302, alpha: 1)
        case "poison":
            pokemonFirstAbilityLabel.backgroundColor = UIColor(red: 0.729, green: 0.494, blue: 0.784, alpha: 1)
        case "fire":
            pokemonFirstAbilityLabel.backgroundColor = UIColor(red: 0.992, green: 0.49, blue: 0.145, alpha: 1)
        case "flying":
            pokemonFirstAbilityLabel.backgroundColor = .systemMint
        case "water":
            pokemonFirstAbilityLabel.backgroundColor = UIColor(red: 0.271, green: 0.573, blue: 0.765, alpha: 1)
        case "bug":
            pokemonFirstAbilityLabel.backgroundColor = .systemFill
        case "normal":
            pokemonFirstAbilityLabel.backgroundColor = UIColor(red: 0.639, green: 0.675, blue: 0.682, alpha: 1)
        case "electric":
            pokemonFirstAbilityLabel.backgroundColor = .systemYellow
        case "ground":
            pokemonFirstAbilityLabel.backgroundColor = .systemBrown
        case "fairy":
            pokemonFirstAbilityLabel.backgroundColor = .systemPurple
        case "fighting":
            pokemonFirstAbilityLabel.backgroundColor = .systemGray5
        case "psychic":
            pokemonFirstAbilityLabel.backgroundColor = .systemPink
        case "rock":
            pokemonFirstAbilityLabel.backgroundColor = .secondaryLabel
        case "steel":
            pokemonFirstAbilityLabel.backgroundColor = .systemTeal
        case "ice":
            pokemonFirstAbilityLabel.backgroundColor = .systemCyan
        case "ghost":
            pokemonFirstAbilityLabel.backgroundColor = UIColor(red: 0.482, green: 0.384, blue: 0.639, alpha: 1)
        case "dragon":
            pokemonFirstAbilityLabel.backgroundColor = .systemRed
        default: break
        }
    }
    
    func secondTypeColor() {
        switch secondAbilityName {
        case "grass":
            pokemonSecondAbilityLabel.backgroundColor = UIColor(red: 0.584, green: 0.761, blue: 0.302, alpha: 1)
        case "poison":
            pokemonSecondAbilityLabel.backgroundColor = UIColor(red: 0.729, green: 0.494, blue: 0.784, alpha: 1)
        case "fire":
            pokemonSecondAbilityLabel.backgroundColor = UIColor(red: 0.992, green: 0.49, blue: 0.145, alpha: 1)
        case "flying":
            pokemonSecondAbilityLabel.backgroundColor = .systemMint
        case "water":
            pokemonSecondAbilityLabel.backgroundColor = UIColor(red: 0.271, green: 0.573, blue: 0.765, alpha: 1)
        case "bug":
            pokemonSecondAbilityLabel.backgroundColor = .systemFill
        case "normal":
            pokemonSecondAbilityLabel.backgroundColor = UIColor(red: 0.639, green: 0.675, blue: 0.682, alpha: 1)
        case "electric":
            pokemonSecondAbilityLabel.backgroundColor = .systemYellow
        case "ground":
            pokemonSecondAbilityLabel.backgroundColor = .systemBrown
        case "fairy":
            pokemonSecondAbilityLabel.backgroundColor = .systemPurple
        case "fighting":
            pokemonSecondAbilityLabel.backgroundColor = .systemGray5
        case "psychic":
            pokemonSecondAbilityLabel.backgroundColor = .systemPink
        case "rock":
            pokemonSecondAbilityLabel.backgroundColor = .secondaryLabel
        case "steel":
            pokemonSecondAbilityLabel.backgroundColor = .systemTeal
        case "ice":
            pokemonSecondAbilityLabel.backgroundColor = .systemCyan
        case "ghost":
            pokemonSecondAbilityLabel.backgroundColor = UIColor(red: 0.482, green: 0.384, blue: 0.639, alpha: 1)
        case "dragon":
            pokemonSecondAbilityLabel.backgroundColor = .systemRed
        default: break
        }
    }
}

extension PokemonViewCell {
    
    enum TypesPokemon {
        case grass
        case poison
        case fire
        case flying
        case water
        case bug
        case normal
        case electric
        case ground
        case fairy
        case fighting
        case psychic
        case rock
        case steel
        case ice
        case ghost
        case dragon
    }
}
