//
//  FavAndTeamCollectionViewController.swift
//  Pokedex
//
//  Created by Sem Koliesnikov on 16/09/2022.
//

import UIKit

class FavAndTeamCollectionViewController: UICollectionViewController {
    
    var isFavorite: Bool?
    var teamDetail: [Pokemon.PokemonModel] = []
    var favoriteDetail: [Pokemon.PokemonModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFavorite == true {
            return favoriteDetail.count
        } else {
            return teamDetail.count
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if isFavorite == true {
            
            // MARK: Load Favorite View
            var cell: UICollectionViewCell
            switch indexPath.row {
                
            case 0:
                guard let favCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamAndFavTitleCell",
                                                                       for: indexPath) as? FavAndTeamTitleCollectionViewCell
                else { return UICollectionViewCell() }
                favCell.titleName(isFavorite: true)
                cell = favCell
                
            default:
                guard let favCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamAndFavCell",
                                                                       for: indexPath) as? FavAndTeamCollectionViewCell
                else { return UICollectionViewCell() }
                favCell.delegate = self
                favCell.loadData(pokemon: favoriteDetail[indexPath.row])
                cell = favCell
            }
            return cell
            
        } else {
            
            // MARK: Load Team View
            var cell: UICollectionViewCell!
            switch indexPath.row {
                
            case 0:
                guard let teamCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamAndFavTitleCell",
                                                                        for: indexPath) as? FavAndTeamTitleCollectionViewCell
                else { return UICollectionViewCell() }
                teamCell.titleName(isFavorite: false)
                cell = teamCell
            default:
                guard let teamCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamAndFavCell",
                                                                        for: indexPath) as? FavAndTeamCollectionViewCell
                else { return UICollectionViewCell() }
                teamCell.delegate = self
                teamCell.loadData(pokemon: teamDetail[indexPath.row])
                cell = teamCell
            }
            return cell
        }
    }
    
    @IBAction func exitButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

extension FavAndTeamCollectionViewController: PokemonProtokol {
    func selectCell(_id: Int, name: String, imgage: String) {
    }
}
