//
//  FavAndTeamCollectionViewController.swift
//  Pokedex
//
//  Created by Sem Koliesnikov on 16/09/2022.
//

import UIKit

class FavAndTeamCollectionViewController: UICollectionViewController {
    
    @IBOutlet var collectionViewSpace: UICollectionView!
    var isFavorite: Bool?
    private var seguesConstant = SeguesConst()
    var teamDetail: [Pokemon.PokemonModel] = []
    var favoriteDetail: [Pokemon.PokemonModel] = []
    var favoritePokemons: [PokemonsSave] = []
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        favoritePokemons = CoreDataStack.coreDataShared.fetchPokemons()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        defineColor()
//        favoritePokemons = CoreDataStack.coreDataShared.fetchPokemons()
    }
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFavorite == true {
            return favoritePokemons.count
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
//                favCell.favoriteDelegate = self
                favCell.loadData(pokemon: favoritePokemons[indexPath.row])
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
                teamCell.loadTeamData(pokemon: teamDetail[indexPath.row])
                cell = teamCell
            }
            return cell
        }
    }
    
    //MARK: - Other options
    
    func defineColor() {
        if isFavorite == true {
            setFavoriteColor()
        } else {
            setTeamColor()
        }
    }
    
    func setFavoriteColor() {
        
        let bgView = UIView(frame: collectionViewSpace.bounds)
        let color1 = UIColor(red: 0.395, green: 0.796, blue: 0.603, alpha: 1).cgColor
        let color2 = UIColor(red: 0.083, green: 0.816, blue: 0.863, alpha: 1).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.collectionViewSpace.frame
        gradientLayer.colors = [color1, color2]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        bgView.layer.insertSublayer(gradientLayer, at: 0)
        self.collectionViewSpace.backgroundView = bgView
    }
    
    func setTeamColor() {
        let bgView = UIView(frame: collectionViewSpace.bounds)
        let color1 = UIColor(red: 0.275, green: 0.275, blue: 0.612, alpha: 1).cgColor
        let color2 = UIColor(red: 0.496, green: 0.194, blue: 0.879, alpha: 1).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.collectionViewSpace.frame
        gradientLayer.colors = [color1, color2]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        bgView.layer.insertSublayer(gradientLayer, at: 0)
        self.collectionViewSpace.backgroundView = bgView
    }
    
    @IBAction func exitButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
   
    // MARK: - Segue to Deatil View
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == seguesConstant.showDetail {
            if let cell = sender as? FavAndTeamCollectionViewCell,
               let indexPath = collectionViewSpace.indexPath(for: cell) {
                
                let pokemonDetail = favoritePokemons[indexPath.row]
                let nav = segue.destination as? UINavigationController
                let detailVC = nav?.topViewController as? DetailViewController
                detailVC?.favoriteDetail = pokemonDetail
                
            }
        }
    }
    
    
    
}

extension FavAndTeamCollectionViewController: PokemonProtokol {
    func selectCell(_id: Int, name: String, imgage: String) {
    }
}
