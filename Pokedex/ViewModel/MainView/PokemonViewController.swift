//
//  ViewController.swift
//  Pokedex
//
//  Created by Sem Koliesnikov on 13/09/2022.
//

import UIKit



class PokemonViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionViewSpace: UICollectionView!
    @IBOutlet weak var titleMainLabel: UILabel!
    @IBOutlet weak var pokemonMainSearchBar: UISearchBar!
    @IBOutlet weak var teamPokemonOptionsButton: UIButton!
    @IBOutlet weak var favoritePokemonOptionsButton: UIButton!
    @IBOutlet weak var countTeamPokemonLabel: UILabel!
    @IBOutlet weak var countFavoritePokemoneLabel: UILabel!
    
    private var apiManager = ListOfPokemonAPIManager()
    private var seguesConstant = SeguesConst()
    var filtredPokemons: [Pokemon.PokemonModel] = []
    var favoritePokemons: [Pokemon.PokemonModel] = []
    var teamPokemons: [Pokemon.PokemonModel] = []
    var pokemons: [Pokemon.PokemonModel] = [] {
        didSet {
            DispatchQueue.main.async { [self] in
                filtredPokemons = pokemons
                favoritePokemons = pokemons[randomPick: 6]
                teamPokemons = pokemons[randomPick: 6]
                collectionViewSpace.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonOptions()
        searchOptions()
        collectionViewSpace.delegate = self
        collectionViewSpace.dataSource = self
        apiManager.fetchCurrent(onCompletion: { [weak self]
            currentPokemonData in self?.pokemons = currentPokemonData })
    }
    
    // MARK: - Displaying data in a cell
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filtredPokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionViewSpace.dequeueReusableCell(withReuseIdentifier: "MainCell",
                                                                 for: indexPath) as? PokemonViewCell
        else { return UICollectionViewCell()}
        cell.delegate = self
        cell.loadData(pokemon: filtredPokemons[indexPath.row])
        return cell
    }
    
    // MARK: - Favorite and Team View
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == seguesConstant.showTeam {
            
            let pokemonTeam = teamPokemons
            let nav = segue.destination as? UINavigationController
            let favAndTeamVC = nav?.topViewController as? FavAndTeamCollectionViewController
            favAndTeamVC?.teamDetail = pokemonTeam
            favAndTeamVC?.isFavorite = false
            
        } else if segue.identifier == seguesConstant.showFavorite {
            
            let favoritePokemon = favoritePokemons
            let nav = segue.destination as? UINavigationController
            let favAndTeamVC = nav?.topViewController as? FavAndTeamCollectionViewController
            favAndTeamVC?.favoriteDetail = favoritePokemon
            favAndTeamVC?.isFavorite = true
        }
    }
    
    //MARK: - Other options
    
    // Search settings
    func searchOptions() {
        pokemonMainSearchBar.delegate = self
        pokemonMainSearchBar.barTintColor = .systemGray6
        pokemonMainSearchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
    }
    
    // Button settings
    func buttonOptions() {
        teamPokemonOptionsButton.backgroundColor = .systemIndigo
        teamPokemonOptionsButton.layer.cornerRadius = 10
        favoritePokemonOptionsButton.backgroundColor = .systemMint
        favoritePokemonOptionsButton.layer.cornerRadius = 10
    }
    
    // MARK: - Sorted view
    @IBAction func sortedMainButton(_ sender: UIButton) {
    }
    
    // MARK: - Team view
    @IBAction func teamPokemonButton(_ sender: UIButton) {
    }
    
    // MARK: - Favorite view
    @IBAction func favoritePokemonButton(_ sender: Any) {
    }
    
    
}

// MARK: - Setting search bar

extension PokemonViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filtredPokemons = searchText.isEmpty ? pokemons : pokemons.filter { (item: Pokemon.PokemonModel) -> Bool in
            return item.name.range(of: searchText, options: .caseInsensitive) != nil
        }
        collectionViewSpace.reloadData()
    }
    
    // closed keyboard
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        self.pokemonMainSearchBar.endEditing(true)
    }
}


extension PokemonViewController: PokemonProtokol {
    func selectCell(_id: Int, name: String, imgage: String) {
    }
}
