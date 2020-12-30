//
//  ViewController.swift
//  TextBoxApp
//
//  Created by Aravindh S on 28/12/20.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate{
    
    //Mark: Properties
    @IBOutlet weak var toDoTextField: UITextField!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var todoTableView: UITableView!
//    var array = [String]()
    var array = [["name":"Chennai","completed":true],["name":"Pondicherry","completed":true],["name":"Goa","completed":true]]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        toDoTextField.delegate = self
        todoTableView.dataSource = self
        todoTableView.delegate = self
//        todoTableView.layer.cornerRadius = 10
//        todoTableView.backgroundColor = UIColor(named: "Gray")
        todoTableView.separatorStyle = .none
        title = "TO-Do List"
        self.todoTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

    }
    
    //Mark: Actions
    @IBAction func addItemEvent(_ sender: UIButton) {
        if toDoTextField.text == ""{
            let alert = UIAlertController(
                title: "Content Required",
                message: "Please enter a valid point to be added",
                preferredStyle: .alert
            )
            let action = UIAlertAction(
                title: "Continue",
                style: .default,
                handler: nil
            )
            alert.addAction(action);
            present(alert, animated: true, completion: nil)
        }
        else {
//            headingLabel.text = doToTextField.text
            self.array.append(["name":toDoTextField.text!,"completed":false])
            self.todoTableView.reloadData()
            toDoTextField.text = ""
        }
    }
    
    //Mark: Add TO-Do List delegate
    func textFieldShouldReturn(_ textField: UITextField ) -> Bool{
        //Hide the keyboard
        toDoTextField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField){
        if textField.text != ""{
//            headingLabel.text = textField.text
//            doToTextField.text = ""
            self.array.append(["name":toDoTextField.text!,"completed":false])
            self.todoTableView.reloadData()
            toDoTextField.text = ""
        }
    }
    //Mark: functions for adding cells in the table view

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = (array[indexPath.row])["name"] as? String
        cell.layer.masksToBounds = true
        cell.layer.borderWidth = 1
        let borderColor: UIColor = UIColor(named: "Gray")!
        cell.layer.borderColor = borderColor.cgColor
        if array[indexPath.row]["completed"] as! Bool == true{
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
        }
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        self.array.remove(at: indexPath.row)
        self.todoTableView.deleteRows(at: [indexPath], with: .automatic)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.todoTableView.deselectRow(at: indexPath, animated: true)
        if self.todoTableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark{
            let alert = UIAlertController(title: "To Do list Updation", message: "Undo the completion?", preferredStyle: .alert)
            let proceed = UIAlertAction(title: "Continue", style: .default, handler: {_ in
                self.todoTableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
            })
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(proceed)
            alert.addAction(cancel)
            self.array[indexPath.row] = ["name":self.array[indexPath.row]["name"]! as! String, "completed": false]
            self.present(alert, animated: true, completion: nil)
        }
        else{
            let alert = UIAlertController(title: "To Do list Updation", message: "Are you sure to mark this as Completed?", preferredStyle: .alert)
            let proceed = UIAlertAction(title: "Continue", style: .default, handler: { _ in
                self.todoTableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
            })
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(proceed)
            alert.addAction(cancel)
            self.array[indexPath.row] = ["name":self.array[indexPath.row]["name"]! as! String, "completed": true]

            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
}
