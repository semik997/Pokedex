//
//  PokemonsSave+CoreDataProperties.swift
//  
//
//  Created by Sem Koliesnikov on 19/09/2022.
//
//

import Foundation
import CoreData


extension PokemonsSave {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PokemonsSave> {
        return NSFetchRequest<PokemonsSave>(entityName: "PokemonsSave")
    }

    @NSManaged public var firstAbility: String?
    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var number: String?
    @NSManaged public var secondAbility: String?

}
