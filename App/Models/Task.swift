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
    var completionDate: Date
    var priority: Priority
    var classTag: HomeworkClass
    var isCompleted: Bool = false
    
    init(title: String, dueDate: Date = Date.now, priority: Priority, classTag: HomeworkClass) {
        self.title = title
        self.dueDate = dueDate
        self.priority = priority
        self.classTag = classTag
        self.completionDate = Date() // The Date gets Initialiced as Today but updated with completion
    }
    
    func getCompletionPoints() -> Int{
        if !isCompleted{
            self.completionDate = Date()
        }
        
        var points = 10
        
        // If the user completes a homework, before dueDate gains 5 extra points for each earlier day
        if self.completionDate < self.dueDate{
            let calendar = Calendar.current
            // Get the int days difference between these dates
            let days = (calendar.dateComponents([.day], from: self.completionDate, to: self.dueDate).day)!
            
            points += days * 5
        }
        
        return points
    }
    
}
