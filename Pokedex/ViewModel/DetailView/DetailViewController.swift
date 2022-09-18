//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Sem Koliesnikov on 17/09/2022.
//

import UIKit

class DetailViewController: UIViewController, UICollectionViewDelegate {
    
    // View Space Outlets
    @IBOutlet var viewControllerSpace: UIView!
    @IBOutlet weak var detailInfoViewSpace: UIView!
    @IBOutlet weak var detailStaticticsViewSpace: UIView!
    @IBOutlet weak var detailGrowthViewSpace: UIView!
    @IBOutlet weak var colletionViewSpace: UICollectionView!
    
    // View Controller Outlets
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var detailStatisticTitleLabel: UILabel!
   
    // Detail Aboute Outlets
    @IBOutlet weak var descriptionAboutLabel: UILabel!

    @IBOutlet weak var firstTypeAboutLabel: UILabel!
    @IBOutlet weak var secondTypeAboutLabel: UILabel!
    @IBOutlet weak var valueNumberAboutLabel: UILabel!
    @IBOutlet weak var valueHeightAboutLabel: UILabel!
    @IBOutlet weak var valueWeightAboutLabel: UILabel!
    @IBOutlet weak var valueCategoriesAboutLabel: UILabel!
    @IBOutlet weak var valueSexAboutLabel: UILabel!
    @IBOutlet weak var valueSkillsAboutLabel: UILabel!
    
    
    // Detail Statistics Outlets
    @IBOutlet weak var valueHpStatisticsLabel: UILabel!
    @IBOutlet weak var valueAttackStatisticsLabel: UILabel!
    @IBOutlet weak var valueDefenceStatisticsLabel: UILabel!
    @IBOutlet weak var valueSpAttackStatisticsLabel: UILabel!
    @IBOutlet weak var valueSpDefStatisticsLabel: UILabel!
    @IBOutlet weak var valueSpeedStatisticsLabel: UILabel!
    @IBOutlet weak var valueTotalStatisticsLabel: UILabel!
    
    @IBOutlet weak var hpStatisticsProgress: UIProgressView!
    @IBOutlet weak var attackStatisticsProgress: UIProgressView!
    @IBOutlet weak var defenceStatisticsProgress: UIProgressView!
    @IBOutlet weak var spAttakStatisticsProgress: UIProgressView!
    @IBOutlet weak var spDefStatisticsProgress: UIProgressView!
    @IBOutlet weak var speedStatisticsProgress: UIProgressView!
    @IBOutlet weak var totalStatisticsProgress: UIProgressView!
    
    
    // Detail Growth Outlets
    @IBOutlet weak var lvl1GrowthLabel: UILabel!
    @IBOutlet weak var lvl2GrowthLabel: UILabel!
    @IBOutlet weak var lvl3GrowthLabel: UILabel!
    @IBOutlet weak var lvl6GrowthLabel: UILabel!
    
    @IBOutlet weak var valueLvl1GrowthLabel: UILabel!
    @IBOutlet weak var valueLvl2GrowthLabel: UILabel!
    @IBOutlet weak var valueLvl3GrowthLabel: UILabel!
    @IBOutlet weak var valueLvl6GrowthLabel: UILabel!
    
    

    
    
    let apiManager = DetailPokemonAPIManager()
    var detail: Pokemon.PokemonModel?
    var extentionsColor = ExtentionsColor()
    var countItems = [1,2,3]
    var pokemonDetail: DetailPokemon.DetailPokemonModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundColor()
        apiManager.fetchDetail(onCompletion: ({[weak self]
            currentPokemonData in self?.pokemonDetail = currentPokemonData}), forIdNumber: detail?.id ?? 1)
        
    }
    
    func setBackgroundColor() {
        viewControllerSpace.backgroundColor = extentionsColor.typeColor(name: detail?.types?[0].type?.name ?? "grass")
//        collectionViewSpace.backgroundColor = extentionsColor.typeColor(name: detail?.types?[0].type?.name ?? "grass")
    }
    
    func setDetail() {
        let imageURL = URL(string: pokemonDetail?.sprites?.other?.dream_world?.front_default ?? "Not Found")
        pokemonImage.sd_setImage(with: imageURL)
        pokemonNameLabel.text = detail?.name
    }
    
    
//    func loadData(pokemon: Pokemon.PokemonModel) {
//        valueNumberAboutLabel.text = "Nr. \(pokemon.id)"
//    }
//    func loadDataDetail(pokemon: DetailPokemon.DetailPokemonModel) {
//        valueHeightAboutLabel.text = "\(pokemon.height)"
//        valueWeightAboutLabel.text = "\(pokemon.weight)"
//    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: UICollectionViewDataSource
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return countItems.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//            guard let detailCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AboutCell",
//                                                                   for: indexPath) as? DetailAboutViewController
//            else { return UICollectionViewCell() }
//            detailCell.delegate = self
//            detailCell.loadData(pokemon: detail!)
//            detailCell.loadDataDetail(pokemon: pokemonDetail!)
//            setDetail()
//            cell = detailCell
//
//        return cell
//    }
    
    @IBAction func exitButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
        

}

