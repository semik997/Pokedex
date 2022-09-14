//
//  ApiManager.swift
//  Pokedex
//
//  Created by Sem Koliesnikov on 13/09/2022.
//

import Foundation
import UIKit
import SystemConfiguration

struct ListOfPokemonAPIManager {
    
    // MARK: - Api request
    func fetchCurrent(onCompletion: (([Pokemon.PokemonModel]) -> Void)?) {
        let urlString = "\(listOfPokemonLinkAPI)"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                if let currentPokemon = self.parseJSON(withData: data) {
                    onCompletion?(currentPokemon)
                }
            }
        }
        task.resume()
    }
    
    // MARK: - Call completion block with json
    
    private func parseJSON(withData data: Data) -> [Pokemon.PokemonModel]? {
        let decoder = JSONDecoder()
        var currentPokemon: [Pokemon.PokemonModel] = []
        do {
            let currentPokemonData = try decoder.decode([Pokemon.PokemonModel].self, from: data)
            
            for index in currentPokemonData {
                currentPokemon.append(index)
            }
            return currentPokemon
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
}
