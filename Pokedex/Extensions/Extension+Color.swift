//
//  ExtentionsColor.swift
//  Pokedex
//
//  Created by Sem Koliesnikov on 17/09/2022.
//

import Foundation
import UIKit

class ExtensionColor {
    
    //MARK: - Set color to types
    
    func typeColor(name: String) -> UIColor {
        switch name {
        case "grass":
            return UIColor(red: 0.584, green: 0.761, blue: 0.302, alpha: 1)
        case "poison":
            return UIColor(red: 0.729, green: 0.494, blue: 0.784, alpha: 1)
        case "fire":
            return UIColor(red: 0.992, green: 0.49, blue: 0.145, alpha: 1)
        case "flying":
            return .systemMint
        case "water":
            return UIColor(red: 0.271, green: 0.573, blue: 0.765, alpha: 1)
        case "bug":
            return .systemIndigo
        case "normal":
            return UIColor(red: 0.639, green: 0.675, blue: 0.682, alpha: 1)
        case "electric":
            return .systemYellow
        case "ground":
            return .systemBrown
        case "fairy":
            return .systemPurple
        case "fighting":
            return .systemGray5
        case "psychic":
            return .systemPink
        case "rock":
            return .systemGray6
        case "steel":
            return .systemTeal
        case "ice":
            return .systemCyan
        case "ghost":
            return UIColor(red: 0.482, green: 0.384, blue: 0.639, alpha: 1)
        case "dragon":
            return .systemRed
        default: break
        }
        return .black
    }
}

extension ExtensionColor {
    enum TypesPokemon {
        case grass
        case poison
        case fire
        case flying
        case water
        case bug
        case normal
        case electric
        case ground
        case fairy
        case fighting
        case psychic
        case rock
        case steel
        case ice
        case ghost
        case dragon
    }
}



