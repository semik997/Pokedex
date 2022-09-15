//
//  ExtentionUIImage.swift
//  Pokedex
//
//  Created by Sem Koliesnikov on 15/09/2022.
//

import Foundation
import UIKit

// MARK: - String in image conversion

extension UIImage {
    
    static func getImage(from string: String) -> UIImage? {
        //Get valid URL
        guard let url = URL(string: string)
        else {
            print("Unable to create URL")
            return nil
        }
        var image: UIImage? = nil
        do {
            //Get valid data
            let data = try Data(contentsOf: url, options: [])
            
            //Make image
            image = UIImage(data: data)
        } catch {
            print(error.localizedDescription)
        }
        return image
    }
    
}
