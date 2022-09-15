//
//  FavoriteTableViewCell.swift
//  Pokedex
//
//  Created by Sem Koliesnikov on 15/09/2022.
//

import UIKit
import SDWebImage

class FavoriteTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imageFavoritePokemon: UIImageView!
    @IBOutlet weak var nameFavoritePokemonLabel: UILabel!
    @IBOutlet weak var numberFavoritePokemonLabel: UILabel!
    @IBOutlet weak var firstAbilityFavoritePokemonLabel: UILabel!
    @IBOutlet weak var secondAbilityFavoritePokemonLabel: UILabel!
    
    private var currentPokemon: Pokemon.PokemonModel?
    weak var delegate: PokemonProtokol?
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension FavoriteTableViewCell {
    func loadData(pokemon: Pokemon.PokemonModel) {
        let imageURL = URL(string: pokemon.sprites.front_default)
        currentPokemon = pokemon
        nameFavoritePokemonLabel.text = pokemon.name
        numberFavoritePokemonLabel.text = "Nr. \(pokemon.id)"
        imageFavoritePokemon.sd_setImage(with: imageURL)
//        imageFavoritePokemon.image = UIImage.getImage(from: pokemon.sprites.front_default)
    }
}
