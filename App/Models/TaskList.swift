//
//  File.swift
//  
//
//  Created by Christian Leyva on 04/04/23.
//

import Foundation

class TaskList: ObservableObject{
    @Published var items = [Task]()
    
    func toggleItemCompletion(_ item: Task) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].isCompleted.toggle()
        }
    }
    
    func deleteItem(_ item: Task) {
        items.removeAll(where: { $0.id == item.id })
    }
    
}
