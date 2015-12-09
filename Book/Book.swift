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
    
    class func addBook(title: String, withCover coverPhoto: String, withISBN isbn: String?, numPages pages: Int, withPriority priority: String, because reason: String, withCategory category: String, writtenBy author: String, withContext context: NSManagedObjectContext) -> Book? {
        
        if let book = NSEntityDescription.insertNewObjectForEntityForName("Book", inManagedObjectContext: context) as? Book {
            book.title = title
            book.pages = NSNumber(integer: pages)
            book.isbn = isbn == nil ? nil : isbn!
            book.reason = reason
            book.coverUrl = coverPhoto
            book.dateAdded = NSDate()
            book.priority = priority
            book.completedItM8 = false
            book.dateStarted = nil
            book.currentPage = nil
            book.dateCompleted = nil
            book.category = Category.getCategoryFromString(category, context: context)
            book.author = Author.getAuthorFromString(author, context: context)
            book.isQueued = false
            
            do {
                try context.save()
                return book
            } catch let error {
                print("Core Data Error: \(error)")
            }
            
            
        }
        
        return nil
        
    }
    
    class func queueBook(context: NSManagedObjectContext, book: Book) -> Bool {
        
        book.isQueued = true
        print("q called")
//        
//        let predicate = NSPredicate(format: "SELF = %@", book.objectID)
//       
//        
//        let fetchRequest = NSFetchRequest(entityName: "Book")
//        fetchRequest.predicate = predicate
//        
//        do {
//            print(fetchAllBooks(context))
//            let fetchedEntities = try context.executeFetchRequest(fetchRequest) as! [Book]
//            fetchedEntities.first?.isQueued = true
//            print(fetchAllBooks(context))
//            // ... Update additional properties with new values
//        } catch {
//            // Do something in response to error condition
//        }
        
//        return true
        
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    
        
    }
    
    class func dequeueBook(context: NSManagedObjectContext, book: Book) -> Bool {
        book.isQueued = false
        do {
            try context.save()
            return true
        } catch let error {
            print("Core Data Error: \(error)")
            return false
        }
        
    }
    
    class func deleteBook(context: NSManagedObjectContext, book: Book) -> Bool {
        context.deleteObject(book)
        print("Goes to Delete")
        do {
            try context.save()
            return true
        } catch let error {
            print("Core Data Error: \(error)")
            return false
        }
    }
    
    class func fetchAllBooks(context: NSManagedObjectContext) -> [Book] {
        let request = NSFetchRequest(entityName: "Book")
        
        if let books = (try? context.executeFetchRequest(request)) as? [Book] {
            return books
        } else {
            return []
        }
    }
    
    class func fetchAllQueuedBooks(context: NSManagedObjectContext) -> [Book] {
        let request = NSFetchRequest(entityName: "Book")
        request.predicate = NSPredicate(format: "isQueued = %@", true)
        
        if let books = (try? context.executeFetchRequest(request)) as? [Book] {
            print("fetchCalled")
            return books
        } else {
            return []
        }
    }
    
    class func deleteAllBooks(context: NSManagedObjectContext) {
        let fetchRequest = NSFetchRequest(entityName: "Book")
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.executeRequest(deleteRequest)
        } catch let error as NSError {
            print("Core Data Error, could not delete because: \(error)")
        }
    }

// Insert code here to add functionality to your managed object subclass

}
