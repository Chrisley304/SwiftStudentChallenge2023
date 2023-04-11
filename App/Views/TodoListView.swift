//
//  SwiftUIView.swift
//
//
//  Created by Christian Leyva on 04/04/23.
//

import SwiftUI

struct TodoListView: View {
    @EnvironmentObject var taskList: TaskList

    @State private var newTodoTitle: String = ""
    @State private var showAddHomeworkSheet = false

    var body: some View {
        NavigationView {
            List {
                Section("Your Progress:") {
                    HStack {
                        ColorCard(color: Color.cyan, title: "Homeworks finished", text: "5").padding(.horizontal, 10)
                        ColorCard(color: Color.yellow, title: "Points earned", text: "50")
                    }
                }.background(Color.clear).headerProminence(.increased)
                Section(header:
                    HStack {
                        Text("Due date today:")
                        Spacer()
                        Button("Give me a homework", action: getRandomHomework)
                    }
                ) {
                    ForEach(taskList.items) { item in
                        HStack {
                            Button(action: {
                                checkHomework(homework: item)
                            }) {
                                Image(systemName: item.isCompleted ? "checkmark.square.fill" : "square")
                                    .foregroundColor(item.isCompleted ? .green : .primary)
                            }
                            Text(item.title)
                                .strikethrough(item.isCompleted, color: .gray)
                            Spacer()
                            Button(action: {
                                deleteHomework(homework: item)
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }.headerProminence(.increased)
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Homeworks")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddHomeworkSheet.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddHomeworkSheet) {
                if #available(iOS 16.0, *) {
                    VStack {
                        HStack {
                            TextField("Add new task", text: $newTodoTitle)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            Button(action: {
                                self.addNewTodo()
                            }) {
                                Text("Add")
                            }
                        }

                        .presentationDetents([.medium])
                    }.padding()
                } else {
                    Text("This app was brought to you by Hacking with Swift")
                }
            }
        }
    }

    private func addNewTodo() {
        guard !newTodoTitle.isEmpty else { return }
        let newTodo = Task(title: newTodoTitle)
        taskList.items.append(newTodo)
        newTodoTitle = ""
    }

    private func getRandomHomework() {
    }

    private func checkHomework(homework: Task) {
        taskList.toggleItemCompletion(homework)
    }

    private func deleteHomework(homework: Task) {
        taskList.deleteItem(homework)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        let taskList = TaskList()
        TodoListView().environmentObject(taskList)
    }
}
