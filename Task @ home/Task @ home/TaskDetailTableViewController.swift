//
//  TaskDetailTableViewController.swift
//  Task @ home
//
//  Created by Tyler on 5/29/16.
//  Copyright © 2016 Tyler. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dueDateTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextField!
    @IBOutlet var dueDatePicker: UIDatePicker!
    
    var task: Task?
    var dueDateValue: NSDate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dueDateTextField.inputView = dueDatePicker
        
        if let task = task {
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    // MARK: - Action Button

    @IBAction func saveButtonTapped(sender: AnyObject) {
        if let task = task {
           task.name = nameTextField.text ?? ""
            task.notes = notesTextField.text ?? ""
        } else {
            let task = Task(name: nameTextField.text ?? "", notes: notesTextField.text ?? "", due: NSDate())
            TaskController.sharedController.addTask(nameTextField.text ?? "", notes: notesTextField.text ?? "", due: NSDate?())
            self.task = task
        }
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func dateValueChanged(sender: AnyObject) {
        self.dueDateTextField.text = sender.date.senderValue()
        self.dueDateValue = sender.date
        
    }
    
    @IBAction func userTappedView(sender: AnyObject) {
        nameTextField.resignFirstResponder()
        dueDateTextField.resignFirstResponder()
        notesTextField.resignFirstResponder()
    }
    
    func updateTask() {
        guard let name = self.nameTextField.text else { return }
        let notes = self.notesTextField.text
        let due = self.dueDateValue
        
        if let task = self.task {
            TaskController.sharedController.updateTask(task, name: name, notes: notes, due: due, isComplete: false)
        } else {
            TaskController.sharedController.addTask(name, notes: notes, due:
            due)
        }
    }

    func updateWithTask(task: Task) {
        self.navigationItem.title = task.name
        nameTextField.text = task.name
        notesTextField.text = task.notes
        dueDateTextField.text = task.due?.dateFormat()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
