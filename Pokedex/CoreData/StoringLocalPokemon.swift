//
//  CoreDataStack.swift
//  Pokedex
//
//  Created by Sem Koliesnikov on 18/09/2022.
//

import Foundation
import CoreData
import UIKit

class StoringLocalPokemon {
    
    static let coreDataShared = StoringLocalPokemon()
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Core Data stack
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PokemonsSave")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Upload Core Data
    func fetchPokemons() -> [PokemonsSave] {
        var favPokemons: [PokemonsSave]?
        let fetchRequest: NSFetchRequest<PokemonsSave> = PokemonsSave.fetchRequest()
        do {
            favPokemons = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return favPokemons ?? []
    }
    
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                context.rollback()
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Save a pokemon to Core Data
    func saveNewPokemon(pokemon: Pokemon.PokemonModel, number: String, status: Bool) {
        
        let count = pokemon.types!.count
        let favPokemon = PokemonsSave(context: context)
        favPokemon.image = pokemon.sprites.front_default
        favPokemon.name = pokemon.name
        favPokemon.number = number
        favPokemon.firstAbility = pokemon.types?[0].type?.name
        for i in 1 ..< count {
            favPokemon.secondAbility = pokemon.types?[i].type?.name
        }
        favPokemon.isFavorite = status
        
        do
        {
            try context.save()
            print("Saved new Pokemon.")
        }
        catch { fatalError("Unable to save data.") }
    }
    
    // MARK: - Deleting a pokemon from Core Data
    func deleteFromData(name: String) {
        
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "PokemonsSave")
        request.predicate = NSPredicate(format:"name = %@", "\(name)")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
            print("Deleted Pokemon")
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}
