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
    var extentionsColor = ExtentionsColor()
    weak var delegate: PokemonProtokol?
    weak var favoriteDelegate: PokemonsSave?
    
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
        firstAbilityFavAndTeamPokemonLabel.layer.masksToBounds = true
        firstAbilityFavAndTeamPokemonLabel.layer.cornerRadius = 10
        secondAbilityFavAndTeamPokemonLabel.layer.masksToBounds = true
        secondAbilityFavAndTeamPokemonLabel.layer.cornerRadius = 10
    }
    // Load data in cell
    func loadTeamData(pokemon: Pokemon.PokemonModel) {
        var checkSecondAbility = false
        let imageURL = URL(string: pokemon.sprites.front_default)
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
    
    func loadData(pokemon: PokemonsSave) {
//        var checkSecondAbility = false
        let imageURL = URL(string: pokemon.image ?? "Not Found")
        nameFavAndTeamPokemonLabel.text = pokemon.name
        numberFavAndTeamPokemonLabel.text = "Nr. \(pokemon.number ?? "1")"
        favAndTeamPokemonImage.sd_setImage(with: imageURL)
        firstAbilityFavAndTeamPokemonLabel.text = pokemon.firstAbility
        secondAbilityFavAndTeamPokemonLabel.text = pokemon.secondAbility
        let firstAbilityName = pokemon.firstAbility
        firstAbilityFavAndTeamPokemonLabel.backgroundColor = extentionsColor.typeColor(name: firstAbilityName ?? "grass")
        if pokemon.secondAbility != nil {
            let secondAbilityName = pokemon.firstAbility
            secondAbilityFavAndTeamPokemonLabel.backgroundColor = extentionsColor.typeColor(name: secondAbilityName ?? "grass")
        }
//            checkSecondAbility = true
//        if checkSecondAbility == false {
//            secondAbilityFavAndTeamPokemonLabel.isHidden = true
//        }
    }

}
