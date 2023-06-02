//
//  DataController.swift
//  CoreTestSabbara
//
//  Created by Rand Alhassoun on 24/05/2023.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    // Responsible for preparing a model
    let container = NSPersistentContainer(name: "RoundModel")//the model
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load data in DataController \(error.localizedDescription)")
            }
        }//clouser
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved successfully. WUHU!!!")
        } catch {
            // Handle errors in our database
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func addRound(name: String, images: String, words: [String], colors: String, colorsShadow: String, context: NSManagedObjectContext) {
        let round = Round(context: context)
        round.id = UUID()
        round.name = name
        round.images = images
        round.words = words // Assign the array directly
        round.colors = colors
        round.colorsShadow = colorsShadow

//colorsShadow
        save(context: context)
    }
//    func addRound(name: String, words: [String], context: NSManagedObjectContext) {
//        let Round = Round(context: context)
//        Round.id = UUID()
//        Round.name = name
//        Round.words = [words]
//
//        save(context: context)
//    }
    
    func editRound(Round: Round, name: String, images: String,  words: [String], colors: String, colorsShadow: String, context: NSManagedObjectContext) {
        Round.name = name
        Round.images = images
        Round.words = words
        Round.colors = colors
        Round.colorsShadow = colorsShadow

        save(context: context)
    }
}
