//
//  TeamTableViewCell.swift
//  Pokedex
//
//  Created by Sem Koliesnikov on 15/09/2022.
//

import UIKit
import SDWebImage

class TeamTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageTeamPokemon: UIImageView!
    @IBOutlet weak var nameTeamPokemonLabel: UILabel!
    @IBOutlet weak var numberTeamPokemonLabel: UILabel!
    @IBOutlet weak var firstAbilityTeamPokemonLabel: UILabel!
    @IBOutlet weak var secondAbilityTeamPokemonLabel: UILabel!
    
    
    private var currentPokemon: Pokemon.PokemonModel?
    weak var delegate: PokemonProtokol?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
}

extension TeamTableViewCell {
    func loadData(pokemon: Pokemon.PokemonModel) {
        let imageURL = URL(string: pokemon.sprites.front_default)
        currentPokemon = pokemon
        nameTeamPokemonLabel.text = pokemon.name
        numberTeamPokemonLabel.text = "Nr. \(pokemon.id)"
        imageTeamPokemon.sd_setImage(with: imageURL)
//        imageTeamPokemon.image = UIImage.getImage(from: pokemon.sprites.front_default)
    }
}
