//
//  FavoriteTableViewController.swift
//  Pokedex
//
//  Created by Sem Koliesnikov on 15/09/2022.
//

import UIKit

class FavoriteTableViewController: UITableViewController {

    private var apiManager = ListOfPokemonAPIManager()
    var randomPokemons: [Pokemon.PokemonModel] = []
    var pokemons: [Pokemon.PokemonModel] = [] {
        didSet {
            DispatchQueue.main.async { [self] in
                randomPokemons = pokemons[randomPick: 5]
                tableView.reloadData()
            }
        }
    }
    
    
    @IBAction func exitButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiManager.fetchCurrent(onCompletion: { [weak self]
            currentPokemonData in self?.pokemons = currentPokemonData })

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return randomPokemons.count
    }

    override func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell",
                                                       for: indexPath) as? FavoriteTableViewCell
        else { return UITableViewCell()}
        cell.delegate = self
        if randomPokemons.count != 0 {
            
            cell.loadData(pokemon: randomPokemons[indexPath.row])
        } else {
            cell.nameFavoritePokemonLabel.text = "Not found"
        }
        return cell
    }
   

}

extension FavoriteTableViewController: PokemonProtokol {
    func selectCell(_id: Int, name: String, imgage: String) {
    }
}

