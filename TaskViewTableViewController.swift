//
//  TaskViewTableViewController.swift
//  Task
//
//  Created by Tyler on 5/25/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit
import CoreData

class TaskViewTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, ButtonTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        TaskController.sharedController.fetchResultsController.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        guard let sections = TaskController.sharedController.fetchResultsController.sections else { return 1 }
        return sections.count
    }


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = TaskController.sharedController.fetchResultsController.sections else { return 0 }
        return sections[section].numberOfObjects
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("taskCell", forIndexPath: indexPath) as! ButtonTableViewCell
        guard let task = TaskController.sharedController.fetchResultsController.objectAtIndexPath(indexPath) as? Task else {
            return UITableViewCell()
        }
        cell.textLabel?.text = task.name
        
        
        return cell
        
        func tableView(tableView: UITableView, titleForHeaderInSection section: Int) ->String? {
            guard let sectionInfo = TaskController.sharedController.fetchResultsController.sections,
                index = Int(sectionInfo[section].name) else {return nil}
            if index == 0 {
                return "Incomplete Tasks"
            } else {
                return "Completed Tasks"
            }
        }
    }
   

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            guard let task = TaskController.sharedController.fetchResultsController.objectAtIndexPath(indexPath) as? Task else { return }
            TaskController.sharedController.removeTask(task)
            }
        }
    
    
    
    // MARK: NSFetchedResultsControllerDelegate 

func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
        case .Delete:
            tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Automatic)
        case .Insert:
            tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Automatic)
        default:
            break
        }
    }
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Delete:
            guard let indexPath = indexPath else {return}
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        case .Insert:
            guard let newIndexPath = newIndexPath else {return}
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
        case .Update:
            guard let indexPath = indexPath else {return}
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        case .Move:
            guard let indexPath = indexPath, newIndexPath = newIndexPath else {return}
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }

    // MARK: ButtonViewCellDelegate
        
        func buttonCellButtonTapped(sender: ButtonTableViewCell) {
            guard let indexPath = tableView.indexPathForCell(sender),
                task = TaskController.sharedController.fetchResultsController.objectAtIndexPath(indexPath) as? Task else {return}
            TaskController.sharedController.isCompleteValueToggle(task)
        }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toTaskDetailSegue" {
            let taskDetailTVC = segue.destinationViewController as? TaskDetailTableViewController
            guard let indexPath = tableView.indexPathForSelectedRow,
                task = TaskController.sharedController.fetchResultsController.objectAtIndexPath(indexPath) as? Task else { return }
                taskDetailTVC?.task = task
            }
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


        
        
        
















