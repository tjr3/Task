//
//  TaskDetailTableViewController.swift
//  Task
//
//  Created by Tyler on 5/25/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    var task: Task?
    var dueDateValue: NSDate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let task = task {
            updateWithTask(task)
            dateTextField.inputView = dueDatePicker
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        if let task = task {
            task.name = nameTextField.text ?? ""
            task.notes = dateTextField.text ?? ""
        } else {
            let task = Task(name: nameTextField.text ?? "", notes: notesTextField.text ?? "", due: NSDate())
            TaskController.sharedController.addTask(nameTextField.text ?? "", notes: notesTextField.text ?? "", due: NSDate?())
            self.task = task
        }
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    
    @IBAction func datePickerChanged(sender: AnyObject) {

        
    }
    
    @IBAction func userTappedView(sender: AnyObject) {
        nameTextField.resignFirstResponder()
        dateTextField.resignFirstResponder()
        notesTextField.resignFirstResponder()
        
    }
    
    
    
    
    // MARK: - Table view data source

    /*
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("taskCell", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
        
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    func updateTask() {
        guard let name = self.nameTextField.text else { return }
        let due = self.dueDateValue
        let note = self.notesTextField.text
        
        if let task = self.task {
            TaskController.sharedController.updateTask(task, name: name, notes: note, due: due, isComplete: false)
        } else {
            TaskController.sharedController.addTask(name, notes: note, due: due)
        }
    }
    
    func updateWithTask(task: Task) {
        self.navigationItem.title = task.name
        nameTextField.text = task.name
        notesTextField.text = task.notes
        dateTextField.text = task.due?.dateFormat()
    
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
