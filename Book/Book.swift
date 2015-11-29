//
//  Book.swift
//  Book
//
//  Created by Aditya Sarkar on 11/29/15.
//  Copyright © 2015 Asad Khaliq. All rights reserved.
//

import Foundation
import CoreData


class Book: NSManagedObject {
    
    class func addBook(title: String, withISBN isbn: String?, numPages pages: Int, withPriority priority: String, because reason: String, withCategory category: String, writtenBy author: String, withContext context: NSManagedObjectContext) -> Book? {
        
        if let book = NSEntityDescription.insertNewObjectForEntityForName("Book", inManagedObjectContext: context) as? Book {
            book.title = title
            book.pages = NSNumber(integer: pages)
            book.isbn = isbn == nil ? nil : isbn!
            book.reason = reason
            book.dateAdded = NSDate()
            book.completedItM8 = false
            book.dateStarted = nil
            book.currentPage = nil
            book.dateCompleted = nil
            book.category = Category.getCategoryFromString(category, context: context)
            book.author = Author.getAuthorFromString(author, context: context)
            return book
        }
        
        return nil
        
    }
    
    class func fetchAllBooks(context: NSManagedObjectContext) -> [Book] {
        let request = NSFetchRequest(entityName: "Book")
        
        if let books = (try? context.executeFetchRequest(request)) as? [Book] {
            return books
        } else {
            return []
        }
    }

// Insert code here to add functionality to your managed object subclass

}
