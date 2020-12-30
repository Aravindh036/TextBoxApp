//
//  ViewController.swift
//  TextBoxApp
//
//  Created by Aravindh S on 28/12/20.
//

import UIKit
class ToDo{
    var name: String?
    var completed: Bool?
    var description: String?
    var taskNo: Int?
    init(name: String, completed: Bool, description: String, taskNo: Int) {
        self.name = name
        self.completed = completed
        self.description = description
        self.taskNo = taskNo
    }
}

class GlobalState {
    static var taskObjArray = [ToDo]()
    static var deletedTaskCount:Int = 0;
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    //Mark: Properties
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var todoTableView: UITableView!
    @IBOutlet weak var toDoTextField: UITextField!
    @IBOutlet weak var todoDescriptionTextField: UITextField!
//    var taskObjArray = [ToDo]()
    //    var array = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        todoTableView.delegate = self
        todoTableView.dataSource = self
//        todoTableView.layer.cornerRadius = 10
//        todoTableView.backgroundColor = UIColor(named: "Gray")
        todoTableView.separatorStyle = .none
        GlobalState.taskObjArray.append(ToDo(name:"Design the solution" , completed: true, description:
                                    """
                                    Identify resources to be monitored
                                    Define users and workflow
                                    Identify event sources by resource type.
                                    Define the relationship between resources and business systems.
                                    Identify tasks and URLs by resource type.
                                    Define the server configuration.
                                    """,
                                             taskNo: GlobalState.taskObjArray.count))
        GlobalState.taskObjArray.append(ToDo(name:"Prepare for implementation" , completed: true, description:
                                    """
                                    Identify the implementation team.
                                    Order the server hardware for production as well as test/quality assurance (QA).
                                    Order console machines.
                                    Order prerequisite software.
                                    Identify the test LPAR.
                                    Identify production LPARs.
                                    """,
                                             taskNo: GlobalState.taskObjArray.count))
        GlobalState.taskObjArray.append(ToDo(name:"Prepare the test/QA environment" , completed: true, description:
                                    """
                                    Install test and QA servers and prerequisite software.
                                    Install console machines and prerequisite software.
                                    Verify connectivity from test and QA servers to test LPAR, Tivoli Enterprise Console(R) server, and console machines.
                                    """,
                                             taskNo: GlobalState.taskObjArray.count))
        title = "TO-Do List"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.todoTableView.reloadData()
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
            let newTask = ToDo(name: toDoTextField.text!, completed: false, description: todoDescriptionTextField.text!, taskNo: GlobalState.taskObjArray.count)
            GlobalState.taskObjArray.append(newTask)
            self.todoTableView.reloadData()
            toDoTextField.text = ""
            todoDescriptionTextField.text = ""
        }
    }
    
    //Mark: functions for adding cells in the table view

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = (GlobalState.taskObjArray[indexPath.row]).name
        cell.layer.masksToBounds = true
        cell.layer.borderWidth = 1
        let borderColor: UIColor = UIColor(named: "Gray")!
        cell.layer.borderColor = borderColor.cgColor
        if GlobalState.taskObjArray[indexPath.row].completed == true{
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
        }
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GlobalState.taskObjArray.count
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        GlobalState.taskObjArray.remove(at: indexPath.row)
        GlobalState.deletedTaskCount = GlobalState.deletedTaskCount + 1
        self.todoTableView.deleteRows(at: [indexPath], with: .automatic)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.todoTableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "showDetails", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailsViewController{
            GlobalState.taskObjArray[todoTableView.indexPathForSelectedRow!.row].taskNo = todoTableView.indexPathForSelectedRow!.row
            destination.task = GlobalState.taskObjArray[todoTableView.indexPathForSelectedRow!.row]
        }
        self.todoTableView.deselectRow(at: todoTableView.indexPathForSelectedRow!, animated: true)
    }
}
