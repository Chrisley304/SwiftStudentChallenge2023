//
//  File.swift
//  
//
//  Created by Christian Leyva on 04/04/23.
//

import Foundation

class TaskList: ObservableObject{
    @Published var items = [Task]()
    @Published var studentPoints = 0
    @Published var homeworksFinished = 0
    
    func toggleItemCompletion(_ item: Task) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            // If it was already compleated rest the points
            if items[index].isCompleted{
                restPoints(points: items[index].getCompletionPoints())
                homeworksFinished -= 1
                items[index].isCompleted = false
                items[index].order -= 3
            }else{
                addPoints(points: items[index].getCompletionPoints())
                homeworksFinished += 1
                items[index].isCompleted = true
                items[index].order += 3
            }
        }
    }
    
    func deleteItem(_ item: Task) {
        items.removeAll(where: { $0.id == item.id })
    }
    
    func addPoints(points: Int){
        studentPoints += points
    }
    
    func restPoints(points: Int){
        studentPoints -= points
    }
    
//    func getCompletedTasks() -> Int{
//        return items.filter({ $0.isCompleted }).count
//    }
    
}
