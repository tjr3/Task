//
//  Task.swift
//  Task @ home
//
//  Created by Tyler on 5/29/16.
//  Copyright © 2016 Tyler. All rights reserved.
//

import Foundation
import CoreData


class Task: NSManagedObject {

    convenience init(name: String, notes: String?, due: NSDate?, isComplete: Bool = false, context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        let entity = NSEntityDescription.entityForName("Task", inManagedObjectContext: context)!
        
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        
        self.name = name
        self.notes = notes
        self.due = due
    }


}
