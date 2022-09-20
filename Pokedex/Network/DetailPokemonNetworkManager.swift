//
//  DetailPokemonAPIManager.swift
//  Pokedex
//
//  Created by Sem Koliesnikov on 17/09/2022.
//

import Foundation
import UIKit
import SystemConfiguration

struct DetailPokemonNetworkManager {
    
    // MARK: - Api request
    func fetchDetail(onCompletion: ((DetailPokemon.DetailPokemonModel) -> Void )?, forIdNumber IdNumber: Int) {
        let urlString = "\(Constants.detailPokemonLinkAPI)\(IdNumber)"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                if let detailPokemon = self.parseJSON(withData: data) {
                    onCompletion?(detailPokemon)
                }
            }
        }
        task.resume()
    }
    
    // MARK: - Call completion block with json
    
    private func parseJSON(withData data: Data) -> DetailPokemon.DetailPokemonModel? {
        let decoder = JSONDecoder()
        var detailPokemon: DetailPokemon.DetailPokemonModel
        do {
            let detailPokemonData = try decoder.decode(DetailPokemon.DetailPokemonModel.self, from: data)
            detailPokemon = detailPokemonData
            return detailPokemon
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
}
