//
//  TaskController.swift
//  Task
//
//  Created by Tyler on 5/25/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import CoreData


class TaskController {

    // MARK: - Properties
    
    static let sharedController = TaskController()
    
    var fetchResultsController: NSFetchedResultsController
    
    init() {
        let request = NSFetchRequest(entityName: "Task")
        let sortDescriptor1 = NSSortDescriptor(key:"isComplete", ascending: false)
        let sortDescriptor2 = NSSortDescriptor(key: "due", ascending: false)
        request.sortDescriptors = [sortDescriptor1, sortDescriptor2]
        fetchResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: Stack.sharedStack.managedObjectContext, sectionNameKeyPath: "isComplete", cacheName: nil)
        _ = try? fetchResultsController.performFetch()
    }
    
    
    // MARK: - Methods
    
    
    func addTask(name: String, notes: String?, due: NSDate?) {
        let _ = Task(name: name, notes: notes, due: due)
        saveToPersistentStorage()
    }
    
    func removeTask(task: Task) {
        task.managedObjectContext?.deleteObject(task)
        saveToPersistentStorage()
    }
    
    func updateTask(task: Task, name: String, notes: String?, due: NSDate?, isComplete: Bool) {
        task.name = name
        task.notes = notes
        task.due = due
        task.isComplete = isComplete
        saveToPersistentStorage()
        
    }
    
    func isCompleteValueToggle(task: Task) {
        task.isComplete = !task.isComplete.boolValue
        saveToPersistentStorage()
    }
    
    
    // MARK: - Persistence
    
    func saveToPersistentStorage() {
        let moc = Stack.sharedStack.managedObjectContext
        do {
            try moc.save()
        } catch {
            print ("Unable to save task!")
        }
    }
    
}

