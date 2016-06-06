//
//  Task+CoreDataProperties.swift
//  Task @ home
//
//  Created by Tyler on 5/29/16.
//  Copyright © 2016 Tyler. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Task {

    @NSManaged var name: String
    @NSManaged var notes: String?
    @NSManaged var isComplete: NSNumber
    @NSManaged var due: NSDate?

}
