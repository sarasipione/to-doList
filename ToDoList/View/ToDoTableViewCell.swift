//
//  ToDoTableViewCell.swift
//  ToDoList
//
//  Created by Sara Sipione on 27/11/2019.
//  Copyright © 2019 Sara Sipione. All rights reserved.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {

    @IBOutlet var toDoView: UIView!
    @IBOutlet var toDoTitleLabel: UILabel!
    @IBOutlet var toDoTagLabel: UILabel!
    @IBOutlet var toDoPriorityView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        toDoView.layer.cornerRadius = 6
        toDoPriorityView.layer.cornerRadius = toDoPriorityView.frame.width/2
    }
}
