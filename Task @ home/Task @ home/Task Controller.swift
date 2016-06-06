//
//  Task Controller.swift
//  Task @ home
//
//  Created by Tyler on 5/29/16.
//  Copyright © 2016 Tyler. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    
    static let sharedController = TaskController()
    
    var fetchedResultsController: NSFetchedResultsController
    
    init() {
        let request = NSFetchRequest(entityName: "Task")
        let sortDescriptor1 = NSSortDescriptor(key: "due", ascending: false)
        let sortDescriptor2 = NSSortDescriptor(key: "isComplete", ascending: false)
        request.sortDescriptors = [sortDescriptor1, sortDescriptor2]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: Stack.sharedStack.managedObjectContext, sectionNameKeyPath: "isComplete", cacheName: nil)
        _ = try? fetchedResultsController.performFetch()
    }
    
    
    
    
    // MARK: Method Signatures
    
    func addTask(name: String, notes: String?, due: NSDate?) {
        let task = Task(name: name, notes: notes, due: due)
        saveToPersitentStorage()
        
    }
    
    func deleteTask(task: Task) {
        task.managedObjectContext?.deletedObjects
        saveToPersitentStorage()
        
    }
    
    func updateTask(task: Task, name: String, notes: String?, due: NSDate?, isComplete: Bool) {
        task.name = name
        task.notes = notes
        task.due = due
        task.isComplete = isComplete
        saveToPersitentStorage()
        
    }
    
    func isCompleteValueTaggle(task: Task) {
        task.isComplete = !task.isComplete.boolValue
        saveToPersitentStorage()
    }
    
    

    // MARK: Persistence
    
    func saveToPersitentStorage() {
        
        let moc = Stack.sharedStack.managedObjectContext
        do {
            try moc.save()
        } catch {
            print("Unable to save task!")
        }
        
    }
}