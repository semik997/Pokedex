
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
    
    var viewModel = DetailViewModel()
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
        fetchInformation(info: viewModel.favoriteDetail)
    }
    
    //MARK: - Setting Basic View
    func setBackgroundColor() {
        if viewModel.favoriteDetail == nil {
            viewControllerSpace.backgroundColor = viewModel.extentionsColor.typeColor(name: viewModel.detail?.types?[0].type?.name ?? "grass")
            basicViewControllerSpace.backgroundColor = viewModel.extentionsColor.typeColor(name: viewModel.detail?.types?[0].type?.name ?? "grass")
        } else {
            viewControllerSpace.backgroundColor = viewModel.extentionsColor.typeColor(name: viewModel.favoriteDetail?.firstAbility ?? "grass")
            basicViewControllerSpace.backgroundColor = viewModel.extentionsColor.typeColor(name: viewModel.favoriteDetail?.firstAbility ?? "grass")
        }
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
        secondTypeAboutLabel.layer.masksToBounds = true
        secondTypeAboutLabel.layer.cornerRadius = 8
        if viewModel.favoriteDetail == nil {
            firstTypeAboutLabel.text = viewModel.detail?.types?[0].type?.name
            let firstAbilityName = viewModel.detail?.types?[0].type?.name
            firstTypeAboutLabel.backgroundColor = viewModel.extentionsColor.typeColor(name: firstAbilityName ?? "grass")
            // Сheck for the presence of the 2nd ability
            for i in 1 ..< (viewModel.detail?.types?.count ?? 1) {
                if secondTypeAboutLabel != nil {
                    secondTypeAboutLabel.text = viewModel.detail?.types?[i].type?.name
                    let secondAbilityName = viewModel.detail?.types?[i].type?.name
                    secondTypeAboutLabel.backgroundColor = viewModel.extentionsColor.typeColor(name: secondAbilityName ?? "grass")
                }
            }
        } else {
            firstTypeAboutLabel.text = viewModel.favoriteDetail?.firstAbility
            firstTypeAboutLabel.backgroundColor = viewModel.extentionsColor.typeColor(name: viewModel.favoriteDetail?.firstAbility ?? "grass")
            // Сheck for the presence of the 2nd ability
            if viewModel.favoriteDetail?.secondAbility != nil {
                secondTypeAboutLabel.text = viewModel.favoriteDetail?.secondAbility
                secondTypeAboutLabel.backgroundColor = viewModel.extentionsColor.typeColor(name: viewModel.favoriteDetail?.secondAbility ?? "grass")
            } else {
                secondTypeAboutLabel.isHidden = true
            }
        }
    }
    
    func setupAboutField() {
        let text = pokemonInfo?.info[1].descriptionText
        descriptionAboutLabel.text = text?.replacingOccurrences(of: "\n", with: " ")
        valueNumberAboutLabel.text = "\(pokemonDetail?.id ?? 1)"
        valueHeightAboutLabel.text = "\(pokemonDetail?.height ?? 1)"
        valueWeightAboutLabel.text = "\(pokemonDetail?.weight ?? 1)"
        valueSkillsAboutLabel.text = "\(pokemonDetail?.moves[0].move.name ?? "-")"
        
        // Checking have this pokemon in Favorite
        for item in viewModel.savePokemonCheck  {
            if Int(item.number!) == viewModel.detail?.id {
                likeButton.image = UIImage(systemName: "heart.fill")
                viewModel.isFavorite = true
            }
        }
    }
    
    
    //MARK: - Setting Statistics View
    func setDetail() {
        let imageURL = URL(string: pokemonDetail?.sprites?.other?.image?.front_default ?? "-")
        pokemonImage.sd_setImage(with: imageURL)
        pokemonNameLabel.text = viewModel.detail?.name
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
    
    //MARK: - Add and Remove from Team
    
    @IBAction func addToTeamButton(_ sender: UIButton) {
        
    }
    func settingAddtoTeamButton() {
        addToTeamButton.setTitle("Add to my team", for: .normal)
        addToTeamButton.setTitle("Remove from team", for: .selected)
    }
    
    //MARK: - Add and Remove from Favorites
    @IBAction func addToFavoriteButton(_ sender: UIBarButtonItem) {
        saveAndRemovePokemon()
    }
    
    func saveAndRemovePokemon() {
        if (viewModel.isFavorite != nil) == false {
            //add to like
            likeButton.image = UIImage(systemName: "heart.fill")
            viewModel.seveToFavorite()
        } else {
            //delited like
            likeButton.image = UIImage(systemName: "heart")
            viewModel.deleteFavorite()
        }
    }
    
    //MARK: - Other functions
    
    @IBAction func exitButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func fetchInformation(info: PokemonsSave?) {
        if info == nil {
            viewModel.apiManager.fetchDetail(onCompletion: ({[weak self]
                currentPokemonData in self?.pokemonDetail = currentPokemonData }), forIdNumber: viewModel.detail?.id ?? 1)
            
            viewModel.detailAPIManager.fetchDescription(onCompletion: ({ [weak self]
                descriptionPokemon in self?.pokemonInfo = descriptionPokemon }), forIdNumber: viewModel.detail?.id ?? 1)
            
            viewModel.savePokemonCheck = StoringLocalPokemon.coreDataShared.fetchPokemons()
            
        } else {
            
            guard let number = Int(viewModel.favoriteDetail?.number ?? "1") else { return }
            
            viewModel.apiManager.fetchDetail(onCompletion: ({[weak self]
                currentPokemonData in self?.pokemonDetail = currentPokemonData }), forIdNumber: number)
            
            viewModel.detailAPIManager.fetchDescription(onCompletion: ({ [weak self]
                descriptionPokemon in self?.pokemonInfo = descriptionPokemon }), forIdNumber: number)
        }
    }
}

