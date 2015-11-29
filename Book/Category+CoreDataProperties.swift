//
//  Category+CoreDataProperties.swift
//  Book
//
//  Created by Aditya Sarkar on 11/29/15.
//  Copyright © 2015 Asad Khaliq. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Category {

    @NSManaged var name: String?
    @NSManaged var books: NSSet?

}
