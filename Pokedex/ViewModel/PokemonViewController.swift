//
//  ViewController.swift
//  Pokedex
//
//  Created by Sem Koliesnikov on 13/09/2022.
//

import UIKit

class PokemonViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private var apiManager = ApiManager()
    var pokemons: [Pokemon.PokemonModel] = [] {
        didSet {
            DispatchQueue.main.async { [self] in
                tableView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleMainLabel: UILabel!
    @IBOutlet weak var pokemonMainSearchBar: UISearchBar!
    @IBOutlet weak var mainPokemonTableView: UITableView!
    @IBOutlet weak var teamPokemonOptionsButton: UIButton!
    @IBOutlet weak var favoritePokemonOptionsButton: UIButton!
    @IBOutlet weak var countTeamPokemonLabel: UILabel!
    @IBOutlet weak var countFavoritePokemoneLabel: UILabel!
    
    
    
    @IBAction func teamPokemonButton(_ sender: UIButton) {
    }
    @IBAction func favoritePokemonButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonOptions()
        apiManager.fetchCurrent(onCompletion: { [weak self]
            currentPokemonData in self?.pokemons = currentPokemonData })
        self.tableView.delegate = self
        self.tableView.dataSource = self

    }
    
    
    
    
    // MARK: - Displaying data in a cell
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell",
                                                       for: indexPath) as? PokemonViewCell
        else { return UITableViewCell()}
        cell.delegate = self
        if pokemons.count != 0 {
            
            cell.loadData(pokemon: pokemons[indexPath.row])
        } else {
            cell.pokemonNameLabel.text = "Not found"
        }
        return cell
    }
    
    func buttonOptions() {

        teamPokemonOptionsButton.backgroundColor = .systemOrange
        teamPokemonOptionsButton.layer.cornerRadius = 10
        
        favoritePokemonOptionsButton.backgroundColor = .systemPink
        favoritePokemonOptionsButton.layer.cornerRadius = 10
    }
}

extension PokemonViewController: PokemonProtokol {
    
    func selectCell(_id: Double, name: String, imgage: String) {

    }
}
