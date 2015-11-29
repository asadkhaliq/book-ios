//
//  Author.swift
//  Book
//
//  Created by Aditya Sarkar on 11/29/15.
//  Copyright © 2015 Asad Khaliq. All rights reserved.
//

import Foundation
import CoreData


class Author: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    class func getAuthorFromString(authorName: String, context: NSManagedObjectContext) -> Author? {
        let request = NSFetchRequest(entityName: "Author")
        request.predicate = NSPredicate(format: "name = %@", authorName)
        
        if let author = (try? context.executeFetchRequest(request))?.first as? Author {
            return author
        } else if let author = NSEntityDescription.insertNewObjectForEntityForName("Author", inManagedObjectContext: context) as? Author {
            author.name = authorName
            return author
        }
        return nil
    }

}
