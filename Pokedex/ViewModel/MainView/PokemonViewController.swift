//
//  ViewController.swift
//  Pokedex
//
//  Created by Sem Koliesnikov on 13/09/2022.
//

import UIKit

class PokemonViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionViewSpace: UICollectionView!
    
    private var apiManager = ListOfPokemonAPIManager()
    var pokemons: [Pokemon.PokemonModel] = [] {
        didSet {
            DispatchQueue.main.async { [self] in
                filtredPokemon = pokemons
                collectionViewSpace.reloadData()
            }
        }
    }
    var filtredPokemon: [Pokemon.PokemonModel] = []
    private var seguesConstant = SeguesConst()
    
    
    @IBOutlet weak var titleMainLabel: UILabel!
    @IBOutlet weak var pokemonMainSearchBar: UISearchBar!
    @IBOutlet weak var teamPokemonOptionsButton: UIButton!
    @IBOutlet weak var favoritePokemonOptionsButton: UIButton!
    @IBOutlet weak var countTeamPokemonLabel: UILabel!
    @IBOutlet weak var countFavoritePokemoneLabel: UILabel!
    
    
    // MARK: - Sorted view
    @IBAction func sortedMainButton(_ sender: UIButton) {
        
    }
    
    
    // MARK: - Team view
    @IBAction func teamPokemonButton(_ sender: UIButton) {
        

    }
    
    // MARK: - Favorite view
    @IBAction func favoritePokemonButton(_ sender: Any) {
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonOptions()
        apiManager.fetchCurrent(onCompletion: { [weak self]
            currentPokemonData in self?.pokemons = currentPokemonData })
        pokemonMainSearchBar.delegate = self
        collectionViewSpace.delegate = self
        collectionViewSpace.dataSource = self
        pokemonMainSearchBar.barTintColor = .systemGray6
        pokemonMainSearchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        
    }

    
    // MARK: - Displaying data in a cell
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filtredPokemon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionViewSpace.dequeueReusableCell(withReuseIdentifier: "MainCell",
                                                       for: indexPath) as? PokemonViewCell
        else { return UICollectionViewCell()}
        cell.delegate = self
            cell.loadData(pokemon: filtredPokemon[indexPath.row])
    
        return cell
    }

    func buttonOptions() {
        
        teamPokemonOptionsButton.backgroundColor = .systemIndigo
        teamPokemonOptionsButton.layer.cornerRadius = 10
        
        favoritePokemonOptionsButton.backgroundColor = .systemMint
        favoritePokemonOptionsButton.layer.cornerRadius = 10
    }
}

// MARK: - Setting search bar

extension PokemonViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtredPokemon = searchText.isEmpty ? pokemons : pokemons.filter { (item: Pokemon.PokemonModel) -> Bool in
            return item.name.range(of: searchText, options: .caseInsensitive) != nil
        }
        collectionViewSpace.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        self.pokemonMainSearchBar.endEditing(true)
    }
}


extension PokemonViewController: PokemonProtokol {
    
    func selectCell(_id: Int, name: String, imgage: String) {
        
    }
}
