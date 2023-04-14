//
//  SwiftUIView.swift
//  
//
//  Created by Christian Leyva on 12/04/23.
//

import SwiftUI


struct TaskListItem: View {
    var task: Task
    let dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    var checkTaskFunc: (Task) -> Void
    
    var body: some View {
        
        VStack {
            HStack {
                Button(action: {
                    checkTaskFunc(task)
                }) {
                    Image(systemName: task.isCompleted ? "checkmark.square.fill" : "square")
                        .foregroundColor(task.isCompleted ? .green : .primary)
                        .scaledToFit()
                        .padding(.horizontal, 10)
                }
                VStack {
                    LeftText(text: task.title, fontStyle: .bold(.body)(), crossText: task.isCompleted).padding(.bottom,0.2)
                    LeftText(text: task.classTag.title, fontStyle: .callout, crossText: task.isCompleted)
                    LeftText(text: "Due date: " + dateFormatter.string(from:task.dueDate), fontStyle: .footnote, crossText: task.isCompleted)
                }
                Spacer()
                PriorityTag(color: task.priority.color, priorityTitle: task.priority.name, textColor: task.priority.textColor)
            }
            
        }
    }
}

struct TaskListItem_Previews: PreviewProvider {
    static var previews: some View {
        List{
            TaskListItem(task: Task(title: "Prueba", priority: Priority(id: 0, name: "High", color: .red), classTag: HomeworkClass(id: 0, title: "Math 📏", color: .blue, textColor: .white)), checkTaskFunc: {_ in
            })
        }
    }
}

struct LeftText: View {
    var text:String
    var fontStyle:Font = .body
    var crossText: Bool = false
    
    var body: some View {
        HStack {
            Text(text).font(fontStyle).strikethrough(crossText, color: .gray)
            Spacer()
        }
    }
}
