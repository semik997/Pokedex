//
//  FavAndTeamTitleCollectionViewCell.swift
//  Pokedex
//
//  Created by Sem Koliesnikov on 17/09/2022.
//

import Foundation
import UIKit

class FavAndTeamTitleCollectionViewCell: UICollectionViewCell {
    
    let identifier = "TeamAndFavTitleCell"
    @IBOutlet weak var titleLabel: UILabel!
    
    func titleName(isFavorite: Bool) {
        if isFavorite == true {
            
            titleLabel.text = "Favorite"
        } else {
            
            titleLabel.text = "My Team"
        }
    }
}
