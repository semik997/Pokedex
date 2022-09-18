//
//  DescriptionPokemonAPIManager.swift
//  Pokedex
//
//  Created by Sem Koliesnikov on 18/09/2022.
//

import Foundation
import UIKit

struct DescriptionPokemonAPIManager {
    
    func fetchDescription(onCompletion: ((DescriptionPokemon.DescriptionPokemonModel) -> Void )?, forIdNumber IdNumber: Int) {
        let urlString = "\(descriptionPokemonLinkAPI)\(IdNumber)"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                if let descriptionPokemon = self.parseJSON(withData: data) {
                    onCompletion?(descriptionPokemon)
                }
            }
        }
        task.resume()
    }
    
    // MARK: - Call completion block with json
    
    private func parseJSON(withData data: Data) -> DescriptionPokemon.DescriptionPokemonModel? {
        let decoder = JSONDecoder()
        var descriptionPokemon: DescriptionPokemon.DescriptionPokemonModel?
        do {
            let descriptionPokemonData = try decoder.decode(DescriptionPokemon.DescriptionPokemonModel.self, from: data)
            descriptionPokemon = descriptionPokemonData
            return descriptionPokemon
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
}

