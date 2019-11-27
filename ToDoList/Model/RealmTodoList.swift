//
//  RealmTodoList.swift
//  ToDoList
//
//  Created by Sara Sipione on 27/11/2019.
//  Copyright © 2019 Sara Sipione. All rights reserved.
//

import UIKit
import RealmSwift

struct RealmTodoList {
   
    init() throws {
        self.realm = try Realm.init()
        print("Realm:", Realm.Configuration.defaultConfiguration.fileURL ?? "")
    }
    
    fileprivate let realm: Realm
    
    func add(todo: Todo) throws {
        try self.realm.write {
            self.realm.add(todo)
        }
    }
    
    func getAll(priority: Priority? = nil) -> [Todo] {
        let results: Results<Todo>
        if let selectedPriority = priority {
            results = realm.objects(Todo.self).filter("priority == \(selectedPriority.rawValue)")
        } else {
            results = realm.objects(Todo.self)
        }
        
        guard !results.isEmpty else {
            return []
        }
        return Array.init(results)
    }
    
    func delete(todo: Todo) throws {
        try self.realm.write {
            self.realm.delete(todo)
        }
    }
}

