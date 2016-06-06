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
        
        dateTextField.inputView = dueDatePicker
        
        if let task = task {
            updateWithTask(task)
            
        }
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
        self.dateTextField.text = sender.date.stringValue()
        self.dueDateValue = sender.date

        
    }
    
    @IBAction func userTappedView(sender: AnyObject) {
        nameTextField.resignFirstResponder()
        dateTextField.resignFirstResponder()
        notesTextField.resignFirstResponder()
        
    }
    
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
