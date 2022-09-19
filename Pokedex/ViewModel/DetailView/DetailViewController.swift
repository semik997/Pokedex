//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Sem Koliesnikov on 17/09/2022.
//

import UIKit
import CoreData

class DetailViewController: UIViewController, UICollectionViewDelegate {
    
    // View Space Outlets
    @IBOutlet var basicViewControllerSpace: UIView!
    @IBOutlet var viewControllerSpace: UIView!
    @IBOutlet weak var navigationBerItem: UINavigationItem!
    @IBOutlet weak var detailInfoViewSpace: UIView!
    @IBOutlet weak var detailStaticticsViewSpace: UIView!
    
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
    
    
    @IBOutlet weak var addToTeamButton: UIButton!
    @IBOutlet weak var likeButton: UIBarButtonItem!
    
    
    let apiManager = DetailPokemonAPIManager()
    let detailAPIManager = DescriptionPokemonAPIManager()
    var extentionsColor = ExtentionsColor()
    var detail: Pokemon.PokemonModel?
    var favoriteDetail: PokemonsSave?
    var pokemonInfo: DescriptionPokemon.DescriptionPokemonModel? {
        didSet {
            DispatchQueue.main.async { [self] in
                setupAboutField()
                
            }
        }
    }
    var pokemonDetail: DetailPokemon.DetailPokemonModel? {
        didSet {
            DispatchQueue.main.async { [self] in
                setDetail()
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTypeLabelOptions()
        setBackgroundColor()
        settingAddtoTeamButton()
        fetchInformation(info: favoriteDetail)

    }
    
    func fetchInformation(info: PokemonsSave?) {
        if info == nil {
            apiManager.fetchDetail(onCompletion: ({[weak self]
                currentPokemonData in self?.pokemonDetail = currentPokemonData }), forIdNumber: detail?.id ?? 1)
            
            detailAPIManager.fetchDescription(onCompletion: ({ [weak self]
                descriptionPokemon in self?.pokemonInfo = descriptionPokemon }), forIdNumber: detail?.id ?? 1)
            
        } else {
            guard let number = Int(favoriteDetail?.number ?? "1") else { return }
            apiManager.fetchDetail(onCompletion: ({[weak self]
                currentPokemonData in self?.pokemonDetail = currentPokemonData }), forIdNumber: number)
            
            detailAPIManager.fetchDescription(onCompletion: ({ [weak self]
                descriptionPokemon in self?.pokemonInfo = descriptionPokemon }), forIdNumber: number)
        }
             
    }
    
    
    
    
    //MARK: - Setting Basic View
    func setBackgroundColor() {
        viewControllerSpace.backgroundColor = extentionsColor.typeColor(name: detail?.types?[0].type?.name ?? "grass")
        basicViewControllerSpace.backgroundColor = extentionsColor.typeColor(name: detail?.types?[0].type?.name ?? "grass")
//        navigationBerItem.standardAppearance = extentionsColor.typeColor(name: detail?.types?[0].type?.name ?? "grass")
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithDefaultBackground()
//        navigationBerItem.standardAppearance = appearance
    }
    
    
    //MARK: - Setting About View
    
    // Setting type label
    func setupTypeLabelOptions() {
        firstTypeAboutLabel.layer.masksToBounds = true
        firstTypeAboutLabel.layer.cornerRadius = 8
        firstTypeAboutLabel.text = detail?.types?[0].type?.name
        let firstAbilityName = detail?.types?[0].type?.name
        firstTypeAboutLabel.backgroundColor = extentionsColor.typeColor(name: firstAbilityName ?? "grass")
        secondTypeAboutLabel.layer.masksToBounds = true
        secondTypeAboutLabel.layer.cornerRadius = 8
        // Сheck for the presence of the 2nd ability
        for i in 1 ..< (detail?.types?.count ?? 1) {
            if secondTypeAboutLabel != nil {
                secondTypeAboutLabel.text = detail?.types?[i].type?.name
                let secondAbilityName = detail?.types?[i].type?.name
                secondTypeAboutLabel.backgroundColor = extentionsColor.typeColor(name: secondAbilityName ?? "grass")
            }
        }
    }
    
    func setupAboutField() {
        let text = pokemonInfo?.info[1].descriptionText
        descriptionAboutLabel.text = text?.replacingOccurrences(of: "\n", with: " ")
        valueNumberAboutLabel.text = "\(detail?.id ?? 1)"
        valueHeightAboutLabel.text = "\(pokemonDetail?.height ?? 1)"
        valueWeightAboutLabel.text = "\(pokemonDetail?.weight ?? 1)"
        valueSkillsAboutLabel.text = "\(pokemonDetail?.moves[0].move.name ?? "-")"
        
        
    }
    
    
    //MARK: - Setting Statistics View
    func setDetail() {
        let imageURL = URL(string: pokemonDetail?.sprites?.other?.image?.front_default ?? "-")
        pokemonImage.sd_setImage(with: imageURL)
        pokemonNameLabel.text = detail?.name
        valueHpStatisticsLabel.text = "\(Int(pokemonDetail?.stats?[0].base_stat ?? 1))"
        hpStatisticsProgress.progressTintColor = progressBar(point: pokemonDetail?.stats?[0].base_stat ?? 60)
        hpStatisticsProgress.setProgress(((pokemonDetail?.stats?[0].base_stat)! / 100), animated: false)
        
        valueAttackStatisticsLabel.text = "\(Int(pokemonDetail?.stats?[1].base_stat ?? 1))"
        attackStatisticsProgress.progressTintColor = progressBar(point: pokemonDetail?.stats?[1].base_stat ?? 60)
        attackStatisticsProgress.setProgress(((pokemonDetail?.stats?[1].base_stat)! / 100), animated: false)
        
        valueDefenceStatisticsLabel.text = "\(Int(pokemonDetail?.stats?[2].base_stat ?? 1))"
        defenceStatisticsProgress.progressTintColor = progressBar(point: pokemonDetail?.stats?[2].base_stat ?? 60)
        defenceStatisticsProgress.setProgress(((pokemonDetail?.stats?[2].base_stat)! / 100), animated: false)
        
        valueSpAttackStatisticsLabel.text = "\(Int(pokemonDetail?.stats?[3].base_stat ?? 1))"
        spAttakStatisticsProgress.progressTintColor = progressBar(point: pokemonDetail?.stats?[3].base_stat ?? 60)
        spAttakStatisticsProgress.setProgress(((pokemonDetail?.stats?[3].base_stat)! / 100), animated: false)
        
        valueSpDefStatisticsLabel.text = "\(Int(pokemonDetail?.stats?[4].base_stat ?? 1))"
        spDefStatisticsProgress.progressTintColor = progressBar(point: pokemonDetail?.stats?[4].base_stat ?? 60)
        spDefStatisticsProgress.setProgress(((pokemonDetail?.stats?[4].base_stat)! / 100), animated: false)
        
        valueSpeedStatisticsLabel.text = "\(Int(pokemonDetail?.stats?[5].base_stat ?? 1))"
        speedStatisticsProgress.progressTintColor = progressBar(point: pokemonDetail?.stats?[5].base_stat ?? 60)
        speedStatisticsProgress.setProgress(((pokemonDetail?.stats?[5].base_stat)! / 100), animated: false)
        
        valueTotalStatisticsLabel.text = "\(Int(pokemonDetail?.base_experience ?? 1))"
        totalStatisticsProgress.progressTintColor = progressBar(point: pokemonDetail?.base_experience ?? 60)
        totalStatisticsProgress.setProgress(((pokemonDetail?.base_experience)! / 100), animated: false)
    }
    
    func progressBar(point: Float) -> UIColor {
        var color: UIColor
        if point >= 50 {
            color = .green
        } else {
            color = .red
        }
        return color
    }
    
    //MARK: - Other options
    
    @IBAction func addToTeamButton(_ sender: UIButton) {
        seveToFavorite()
    }
    
    func settingAddtoTeamButton() {
        addToTeamButton.titleLabel?.text = "Add to my team"
        
    }
    
    
    
    @IBAction func addToFavoriteButton(_ sender: UIBarButtonItem) {
        
        
    }
    
    func seveToFavorite() {
        let number: String = "\(detail?.id ?? 1)"
        CoreDataStack.coreDataShared.saveNewPokemon(pokemon: detail!, number: number)
    }
    
    
    
    
    @IBAction func exitButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    

}

