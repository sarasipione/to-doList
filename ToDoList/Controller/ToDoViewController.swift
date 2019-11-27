//
//  ViewController.swift
//  ToDoList
//
//  Created by Sara Sipione on 27/11/2019.
//  Copyright © 2019 Sara Sipione. All rights reserved.
//

import UIKit

class ToDoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
        
    var todoList: RealmTodoList?
    var todoListObjects: [Todo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            self.todoList = try RealmTodoList.init()
            self.tableView.dataSource = self
            self.tableView.delegate = self
        } catch let error {
            print(error)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.todoListObjects = todoList?.getAll() ?? []
        self.tableView.reloadData()
    }
    
    @IBAction func addButtonClicked(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "segueToAddViewController", sender: nil)
    }
    
    @IBAction func priorityFilterSelected(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex - 1
        
        guard let priority = Priority.init(rawValue: index) else {
            todoListObjects = todoList?.getAll() ?? []
            tableView.reloadData()
            return
        }
        
        todoListObjects = todoList?.getAll(priority: priority) ?? []
        tableView.reloadData()
        
    }
    
}


extension ToDoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoListObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todo = todoListObjects[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! ToDoTableViewCell
        cell.toDoTitleLabel.text = todo.title
        cell.toDoTagLabel.text = todo.tag
        cell.toDoPriorityView.backgroundColor = Priority.init(rawValue: todo.priority)?.color()
        return cell
    }
}


extension ToDoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, handler) in
            self.todoListObjects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .right)
        }
        
        let swipeAction = UISwipeActionsConfiguration(actions: [action])
        try! self.todoList?.delete(todo: self.todoListObjects[indexPath.row])
        return swipeAction
    }
}


