//
//  Category.swift
//  Book
//
//  Created by Aditya Sarkar on 11/29/15.
//  Copyright © 2015 Asad Khaliq. All rights reserved.
//

import Foundation
import CoreData


class Category: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    class func getCategoryFromString(catString: String, context: NSManagedObjectContext) -> Category? {
        let request = NSFetchRequest(entityName: "Category")
        request.predicate = NSPredicate(format: "name = %@", catString)
        
        if let category = (try? context.executeFetchRequest(request))?.first as? Category {
            return category
        } else if let category = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: context) as? Category {
            category.name = catString
            return category
        }
        return nil
    }
}
