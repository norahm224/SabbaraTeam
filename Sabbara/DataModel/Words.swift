//
//  Words.swift
//  CoreTestSabbara
//
//  Created by Rand Alhassoun on 24/05/2023.
//

import Foundation
import CoreData

@objc(Words) // Use the correct entity name here
public class Words: NSManagedObject {
    // Add any other properties or methods for your entity
}

extension Words {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Words> {
        return NSFetchRequest<Words>(entityName: "Words") // Use the correct entity name here
    }

    @NSManaged public var words: [String]?
}
