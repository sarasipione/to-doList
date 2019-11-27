//
//  AddToDoViewController.swift
//  ToDoList
//
//  Created by Sara Sipione on 27/11/2019.
//  Copyright © 2019 Sara Sipione. All rights reserved.
//

import UIKit
import TagListView

class AddToDoViewController: UIViewController {
    
    @IBOutlet weak var tagListView: TagListView!
    
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var tagTextField: UITextField!
    @IBOutlet var priorityButtons: [UIButton]!
    
    var tagList = [String]()
   
    var selectedPriority: Priority?
    var todoList: RealmTodoList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setUpTag()
        
        do {
            todoList = try RealmTodoList.init()
        } catch let error {
            print(error)
        }
        
        for button in priorityButtons {
            guard let priority = Priority.init(rawValue: button.tag) else { return }
            button.backgroundColor = priority.color()
            button.layer.cornerRadius = button.frame.width/2
            button.alpha = 0.5
        }
    }

    
    
    @IBAction func addButtonClicked(_ sender: UIBarButtonItem) {
        
        guard let title = titleTextView.text, !title.isEmpty else {
            print("title is empty")
            let alert = UIAlertController(title: "Title Missing", message: "Add a title at your Todo", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Let's add a title!", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        guard let tag = tagTextField.text, !tag.isEmpty else {
            print("tag is empty")
            let alert = UIAlertController(title: "Tag Missing", message: "Add a tag at your Todo", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Let's add a tag!", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        guard let priority = selectedPriority else {
            print("priority is nil")
            let alert = UIAlertController(title: "Priority Missing", message: "Add a priority at your Todo", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Add your priority!", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let todo = Todo.init()
        todo.title = title
        todo.tag = tag
        todo.priority = priority.rawValue
        
        do {
            try todoList?.add(todo: todo)
            self.navigationController?.popViewController(animated: true)
        } catch let error {
            print(error)
        }
    }
    
    
        @IBAction func priorityButtonClicked(_ sender: UIButton) {
        let selectedButton = sender.tag
        guard let priority = Priority.init(rawValue: selectedButton) else { return }
        
        selectedPriority = priority
        
        for button in priorityButtons {
            if button == sender {
                button.alpha = 1.5
            } else {
                button.alpha = 0.3
            }
        }
    }
}
    
extension AddToDoViewController: TagListViewDelegate {
   
    
    func setUpTag() {
        
        tagListView.delegate = self
        tagListView.textFont = UIFont.systemFont(ofSize: 18)
        tagListView.backgroundColor = .clear
        tagListView.addTags(["work", "family", "sport", "shopping", "music", "event", "home", "friends", "grocery", "to-do"])
    }
    
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        tagTextField.text = tagView.titleLabel?.text
        tagView.isSelected = !tagView.isSelected
    
    }
    
}
