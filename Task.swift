//
//  Task.swift
//  Task
//
//  Created by Tyler on 5/25/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import CoreData

@objc(Task)
class Task: NSManagedObject {

    convenience init(name: String, notes: String? = nil, due: NSDate? = nil, isComplete: Bool = false, context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        
        // there is no graceful way to respond to a failure on NSEntityDescription.entityForName, force unwrapping and forcing a crash is the desired behavior
        
        // designated initializer
        
        let entity = NSEntityDescription.entityForName("Task", inManagedObjectContext: context)!
        
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        
        self.name = name
        self.notes = notes
        self.due = due
    }

}
