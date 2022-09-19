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
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var sortedButton: UIButton!
    
    var viewModel = PokemonViewModel()

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        numberOfPokemons()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonOptions()
        searchOptions()
        subscribeToEvents()
        viewModel.fetchPokemons()
    }
    
    private func configureCollectionView() {
        collectionViewSpace.delegate = self
        collectionViewSpace.dataSource = self
    }
    
    private func subscribeToEvents() {
        viewModel.onReloadCollection = {
            // main async ??
            self.collectionViewSpace.reloadData()
        }
        viewModel.onShowHud = {
            // async ??
            self.spinner.startAnimating()
        }
        viewModel.onDismissHud = {
            DispatchQueue.main.async { [self] in
                self.spinner.stopAnimating()
            }
            self.spinner.isHidden = true
        }
    }
    
    
    // MARK: - Displaying data in a cell
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.filtredPokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionViewSpace.dequeueReusableCell(withReuseIdentifier: "MainCell",
                                                                 for: indexPath)as? PokemonViewCell
        else { return UICollectionViewCell()}
        cell.delegate = self
        cell.loadConfigure(pokemon: viewModel.filtredPokemons[indexPath.row])
        return cell
    }
    
    // MARK: - Segue to Favorite and Team View
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constants.SeguesConst.showTeam {
            
            let nav = segue.destination as? UINavigationController
            let favAndTeamVC = nav?.topViewController as? FavAndTeamCollectionViewController
            favAndTeamVC?.viewModel.isFavorite = false
            
        } else if segue.identifier == Constants.SeguesConst.showFavorite {
            
            let nav = segue.destination as? UINavigationController
            let favAndTeamVC = nav?.topViewController as? FavAndTeamCollectionViewController
            favAndTeamVC?.viewModel.isFavorite = true
        }
        
        //MARK: - Segue to Detail View
        
        if segue.identifier == Constants.SeguesConst.showDetail {
            if let cell = sender as? PokemonViewCell,
               let indexPath = collectionViewSpace.indexPath(for: cell) {
                
                let pokemonDetail = viewModel.filtredPokemons[indexPath.row]
                let nav = segue.destination as? UINavigationController
                let detailVC = nav?.topViewController as? DetailViewController
                detailVC?.viewModel.detail = pokemonDetail
            }
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
        favoritePokemonOptionsButton.applyGradient(
            colours: [UIColor(red: 0.395, green: 0.796, blue: 0.603, alpha: 1),
                      UIColor(red: 0.083, green: 0.816, blue: 0.863, alpha: 1)],
            cornerRadius: 10,
            startPoint: CGPoint(x: 0, y: 0.5),
            endPoint: CGPoint(x: 1, y: 0.5))
        favoritePokemonOptionsButton.layer.cornerRadius = 10
        
        teamPokemonOptionsButton.applyGradient(
            colours: [UIColor(red: 0.275, green: 0.275, blue: 0.612, alpha: 1),
                      UIColor(red: 0.496, green: 0.194, blue: 0.879, alpha: 1)],
            cornerRadius: 10,
            startPoint: CGPoint(x: 0, y: 0.5),
            endPoint: CGPoint(x: 1, y: 0.5))
        teamPokemonOptionsButton.layer.cornerRadius = 10
    }
    
    func numberOfPokemons() {
        let favCount = StoringLocalPokemon.coreDataShared.fetchPokemons().count - 1
        let teamCount = 0
        countFavoritePokemoneLabel.text = "\(favCount) Pokemons"
        countTeamPokemonLabel.text = "\(teamCount) Pokemons"
    }
    
    
    // MARK: - Sorted view
    @IBAction func sortedMainButton(_ sender: UIButton) {
        configureButtonMenu()
    }
    
    func configureButtonMenu() {
        sortedButton.menu = viewModel.demoMenu
        sortedButton.showsMenuAsPrimaryAction = true
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
        viewModel.filtredPokemons = []
        if searchText == "" {
            viewModel.filtredPokemons = viewModel.pokemons
        } else {
            for pokemon in viewModel.pokemons {
                if pokemon.name.lowercased().contains(searchText.lowercased()) || "\(pokemon.id)".lowercased().contains(searchText.lowercased()) {
                    viewModel.filtredPokemons.append(pokemon)
                }
            }
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
