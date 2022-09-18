//
//  FavAndTeamCollectionViewCell.swift
//  Pokedex
//
//  Created by Sem Koliesnikov on 16/09/2022.
//

import UIKit

class FavAndTeamCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var favAndTeamPokemonImage: UIImageView!
    @IBOutlet weak var nameFavAndTeamPokemonLabel: UILabel!
    @IBOutlet weak var numberFavAndTeamPokemonLabel: UILabel!
    @IBOutlet weak var firstAbilityFavAndTeamPokemonLabel: UILabel!
    @IBOutlet weak var secondAbilityFavAndTeamPokemonLabel: UILabel!
    
//    private var currentPokemon: Pokemon.PokemonModel?
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
        var checkSecondAbility = false
        let imageURL = URL(string: pokemon.sprites.front_default)
//        currentPokemon = pokemon
        nameFavAndTeamPokemonLabel.text = pokemon.name
        numberFavAndTeamPokemonLabel.text = "Nr. \(pokemon.id)"
        favAndTeamPokemonImage.sd_setImage(with: imageURL)
        firstAbilityFavAndTeamPokemonLabel.text = pokemon.types?[0].type?.name
        for i in 1 ..< pokemon.types!.count {
            secondAbilityFavAndTeamPokemonLabel.text = pokemon.types?[i].type?.name
            checkSecondAbility = true
        }
        if checkSecondAbility == false {
            secondAbilityFavAndTeamPokemonLabel.isHidden = true
        }
    }
}
