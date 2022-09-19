//
//  CoreDataStack.swift
//  Pokedex
//
//  Created by Sem Koliesnikov on 18/09/2022.
//

import Foundation
import CoreData
import UIKit

class CoreDataStack {
    
    static let coreDataShared = CoreDataStack()
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
    
    
    
    func saveNewPokemon(pokemon: Pokemon.PokemonModel, number: String) {
        
        let favPokemon = PokemonsSave(context: context)
        favPokemon.image = pokemon.sprites.front_default
        favPokemon.name = pokemon.name
        favPokemon.number = number
        favPokemon.firstAbility = pokemon.types?[0].type?.name
        for i in 1 ..< pokemon.types!.count {
            favPokemon.secondAbility = pokemon.types?[i].type?.name
        }
        
        
        do
        {
            try context.save()
            print("Saved new notifications.")
        }
        catch { fatalError("Unable to save data.") }
    }
    
}

