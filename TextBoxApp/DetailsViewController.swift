//
//  DetailsViewController.swift
//  TextBoxApp
//
//  Created by Aravindh S on 30/12/20.
//

import UIKit

class DetailsViewController: UIViewController {

//    @IBOutlet weak var customNavigationitem: UINavigationItem!
    var task: ToDo?
    @IBOutlet weak var taskStatusToggle: UISwitch!
    @IBOutlet weak var taskNameTextView: UITextView!
    @IBOutlet weak var taskDescriptionTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Item Details"
        self.taskStatusToggle.isOn = task!.completed!
        self.taskNameTextView.text = task!.name!
        self.taskDescriptionTextView.text = task!.description!
    }

    @IBAction func taskStatusChangeHandler(_ sender: UISwitch) {
        GlobalState.taskObjArray[self.task!.taskNo!].completed = self.taskStatusToggle.isOn
    }

}
