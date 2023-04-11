//
//  File.swift
//  
//
//  Created by Christian Leyva on 04/04/23.
//

import Foundation

class Task: Identifiable {
    let id = UUID()
    var title: String
    var dueDate: Date
    var toDoDate: Date
    var priorityTag: String
    var classTag: String
    var isCompleted: Bool = false
    
    init(title: String, dueDate: Date = Date.now, toDoDate: Date = Date.now, priorityTag: String = "low", classTag: String = "") {
        self.title = title
        self.dueDate = dueDate
        self.toDoDate = toDoDate
        self.priorityTag = priorityTag
        self.classTag = classTag
    }
    
}
