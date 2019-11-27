//
//  Todo.swift
//  ToDoList
//
//  Created by Sara Sipione on 27/11/2019.
//  Copyright © 2019 Sara Sipione. All rights reserved.
//

import UIKit
import RealmSwift

class Todo: Object {
    
    @objc dynamic var title: String?
    @objc dynamic var tag: String?
    @objc dynamic var priority: Int = 0
}
