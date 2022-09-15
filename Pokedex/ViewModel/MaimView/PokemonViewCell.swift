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

class PokemonViewCell: UITableViewCell {
    
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonIdLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonFirstAbilityLabel: UILabel!
    @IBOutlet weak var pokemonSecondAbilityLabel: UILabel!
    
    
    
    private var currentPokemon: Pokemon.PokemonModel?
    weak var delegate: PokemonProtokol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // add shadow on cell
        backgroundColor = .clear // very important
        layer.masksToBounds = false
        layer.shadowOpacity = 0.23
        layer.shadowRadius = 10
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.black.cgColor

        // add corner radius on `contentView`
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // this will turn on `masksToBounds` just before showing the cell
        cell.contentView.layer.masksToBounds = true
        // if you do not set `shadowPath` you'll notice laggy scrolling
        // add this in `willDisplay` method
        let radius = cell.contentView.layer.cornerRadius
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: radius).cgPath
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
