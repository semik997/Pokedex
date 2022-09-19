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
    
    var extentionsColor = ExtentionsColor()
    weak var favoriteDelegate: PokemonsSave?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellConfigure()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        secondAbilityFavAndTeamPokemonLabel.text = nil
        firstAbilityFavAndTeamPokemonLabel.text = nil
        secondAbilityFavAndTeamPokemonLabel.backgroundColor = .white
    }
    
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
        // label Configure
        firstAbilityFavAndTeamPokemonLabel.layer.masksToBounds = true
        firstAbilityFavAndTeamPokemonLabel.layer.cornerRadius = 10
        secondAbilityFavAndTeamPokemonLabel.layer.masksToBounds = true
        secondAbilityFavAndTeamPokemonLabel.layer.cornerRadius = 10
    }
    // Load data in cell
    func loadConfigure(pokemon: PokemonsSave) {
        let imageURL = URL(string: pokemon.image ?? "Not Found")
        nameFavAndTeamPokemonLabel.text = pokemon.name
        numberFavAndTeamPokemonLabel.text = "No. \(pokemon.number ?? "1")"
        favAndTeamPokemonImage.sd_setImage(with: imageURL)
        firstAbilityFavAndTeamPokemonLabel.text = pokemon.firstAbility
        firstAbilityFavAndTeamPokemonLabel.backgroundColor = extentionsColor.typeColor(name: pokemon.firstAbility ?? "grass")
        if pokemon.secondAbility != nil {
            secondAbilityFavAndTeamPokemonLabel.text = pokemon.secondAbility
            secondAbilityFavAndTeamPokemonLabel.backgroundColor = extentionsColor.typeColor(name: pokemon.secondAbility ?? "grass")
        }
    }
}
