//
//  TODOView.swift
//  StudyCompa
//
//  Created by Christian Leyva on 04/04/23.
//

import SwiftUI

struct TodoListView: View {
    @ObservedObject var todoList: TodoList
    
    @State private var newTodoTitle: String = ""
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Nueva tarea")) {
                    HStack {
                        TextField("Agregar nueva tarea", text: $newTodoTitle)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button(action: {
                            self.addNewTodo()
                        }) {
                            Text("Agregar")
                        }
                    }
                }
                Section(header: Text("Tareas pendientes")) {
                    ForEach(todoList.items) { item in
                        HStack {
                            Button(action: {
                                self.todoList.toggleItemCompletion(item)
                            }) {
                                Image(systemName: item.isCompleted ? "checkmark.square.fill" : "square")
                                    .foregroundColor(item.isCompleted ? .green : .primary)
                            }
                            Text(item.title)
                                .strikethrough(item.isCompleted, color: .gray)
                            Spacer()
                            Button(action: {
                                self.todoList.deleteItem(item)
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Tareas pendientes")
            .navigationBarItems(trailing: EditButton())
        }
    }
    
    private func addNewTodo() {
        guard !newTodoTitle.isEmpty else { return }
        let newTodo = TodoItem(title: newTodoTitle)
        todoList.items.append(newTodo)
        newTodoTitle = ""
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        let todoList = TodoList()
        todoList.items = [            TodoItem(title: "Comprar comida para el perro"),            TodoItem(title: "Llamar al médico"),            TodoItem(title: "Preparar la presentación del trabajo")        ]
        return TodoListView(todoList: todoList)
    }
}
