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
    
    var tasksArray: [Task] = []
    
    var mockData: [Task] {
        let task1 = Task(name: "Make gumbo", notes: "In the fridge door")
        let task2 = Task(name: "Take Grandma to the shop", notes: "Dont forget to pickup medication")
        task2.isComplete = true
        let task3 = Task(name: "Review class notes", notes: "Chapter 4, section 2.1-2.6")
        let task4 = Task(name: "Dave's Birthday Present", notes: "Eddie Bauer")
        
        return [task1, task2, task3, task4]
    }
    
    
    
    var completedTasks: [Task] {
        return tasksArray.filter({$0.isComplete == true})
    }
    
    var incompleteTask: [Task] {
        return tasksArray.filter({$0.isComplete == false})
    }
    
    init() {
        self.tasksArray = fetchTask()
    }
    

    
    
    // MARK: - Methods
    
    
    func addTask(name: String, notes: String?, due: NSDate?) {
        let _ = Task(name: name, notes: notes, due: due)
        saveToPersistentStorage()
        tasksArray = fetchTask()
    }
    
    func removeTask(task: Task) {
            task.managedObjectContext?.deleteObject(task)
            saveToPersistentStorage()
            tasksArray = fetchTask()
        
    }
    
    func updateTask(task: Task, name: String, notes: String?, due: NSDate?, isComplete: Bool) {
        task.name = name
        task.notes = notes
        task.due = due
        task.isComplete = isComplete
        saveToPersistentStorage()
        tasksArray = fetchTask()
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
    
    func fetchTask() -> [Task] {
        let request = NSFetchRequest(entityName: "Task")
        let task = (try? Stack.sharedStack.managedObjectContext.executeFetchRequest(request)) as? [Task]
        return task ?? []
    }
}