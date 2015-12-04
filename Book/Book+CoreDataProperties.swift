//
//  Book+CoreDataProperties.swift
//  Book
//
//  Created by Aditya Sarkar on 12/4/15.
//  Copyright © 2015 Asad Khaliq. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Book {

    @NSManaged var completedItM8: NSNumber?
    @NSManaged var currentPage: NSNumber?
    @NSManaged var dateAdded: NSDate?
    @NSManaged var dateCompleted: NSDate?
    @NSManaged var dateStarted: NSDate?
    @NSManaged var isbn: String?
    @NSManaged var pages: NSNumber?
    @NSManaged var priority: String?
    @NSManaged var reason: String?
    @NSManaged var title: String?
    @NSManaged var coverUrl: String?
    @NSManaged var author: Author?
    @NSManaged var category: Category?

}
