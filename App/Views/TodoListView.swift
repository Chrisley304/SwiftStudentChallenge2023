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
    let today = Date()
    @State private var showAddHomeworkSheet = false
    @State private var newHomeworkDate = Date()
    @State private var randomHomework: Int = 0
    @State private var randomHomeworkGroupedTasksDate:Date = Date()
//    private var classes = ["Class", "Math 📏", "Biology 🌱", "Spanish", "English", "History 📚"]
    private var classes = [HomeworkClass(id: 0, title: "Class", color: .gray), HomeworkClass(id:1, title: "Math 📏", color: .blue, textColor: .white) , HomeworkClass(id:2, title: "Biology 🌱", color: .green) , HomeworkClass(id: 3, title: "Spanish", color: .red), HomeworkClass(id:4, title: "English", color: .blue), HomeworkClass(id:5, title: "History 📚", color: .brown)]
    @State private var selectedClass = 0
    private var priorities = [Priority(id: 0, name: "High 🚨", color: .red, textColor: .white), Priority(id: 1, name: "Medium ⚠️", color: .yellow), Priority(id: 2, name: "Low ✌🏼", color: .green, textColor: .white)]
    @State private var selectedPriority = 0
    @State public var showHomeworkModal = false

    var body: some View {
        NavigationView {
            List {
                Section("Your Progress:") {
                    HStack {
                        ColorCard(color: Color.cyan, title: "Homeworks finished", text: String(taskList.homeworksFinished)).padding(.horizontal, 10)
                        ColorCard(color: Color.yellow, title: "Points earned", text: String(taskList.studentPoints))
                    }
                }.background(Color.clear).headerProminence(.increased)

                if groupedTasks.isEmpty{
                    Text("You don't have homeworks. Add a new one!")
                }else{
                    ForEach(groupedTasks.keys.sorted(), id: \.self) { dueDate in
                        Section(header: HStack{
                            Text(dueDateSectionTitle(for: dueDate))
                            Spacer()
                            Button("Give me a homework"){
                                randomHomeworkGroupedTasksDate = dueDate
                                randomHomework = Int.random(in: 0..<groupedTasks[dueDate]!.count)
                                showHomeworkModal.toggle()
                            }
                        }) {
                            ForEach(groupedTasks[dueDate]!) { item in
                                TaskListItem(task: item, checkTaskFunc: checkHomework)
                            }
                        }
                    }.headerProminence(.increased)
                }
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
            .popup(isPresented: showHomeworkModal){
                HomeworkModalCard(title: groupedTasks[randomHomeworkGroupedTasksDate]?[randomHomework].title ?? "", homeworkClass: groupedTasks[randomHomeworkGroupedTasksDate]?[randomHomework].classTag ?? classes[0], showHomeworkModal: $showHomeworkModal)
            }
            .sheet(isPresented: $showAddHomeworkSheet) {
                if #available(iOS 16.0, *) {
                    VStack {
                        HStack {
                            Spacer()
                            Text("Add new homework").bold()
                            Spacer()
                            Button(action: {
                                showAddHomeworkSheet.toggle()
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.gray)
                            }
                        }.padding(.vertical)
                        VStack {
                            HStack {
                                TextField("Homework short description", text: $newTodoTitle)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }.padding(.bottom)
                            DatePicker("Homework due date⏳:", selection: $newHomeworkDate, in: today..., displayedComponents: [.date]).padding(.bottom)
                            HStack {
                                Text("Select a class 📓:")
                                Spacer()
                                Picker("Select a class 📓", selection: $selectedClass) {
                                    ForEach(classes, id: \.id) { homClass in
                                        Text(homClass.title)
                                    }
                                }

                            }.padding(.bottom)

                            //                        LeftTextSubtitle(text: "Priority:")
                            Picker("Priority", selection: $selectedPriority) {
                                ForEach(priorities, id: \.id) { priority in
                                    Text(priority.name)
                                }
                            }.pickerStyle(.segmented)

                            Spacer()
                            Button(action: self.addNewTodo) {
                                Text("Add Homework ✏️").padding(5)
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.blue)
                            .disabled(!isFormValid)
                        }

                        .presentationDetents([.fraction(0.45)])
                    }.padding(.horizontal)
                } else {
                    Text("TODO: ADD THE SAME Vstack")
                }
            }
        }
    }

    private func addNewTodo() {
        guard !newTodoTitle.isEmpty else { return }
        let newTodo = Task(title: newTodoTitle, dueDate: newHomeworkDate, priority: priorities[selectedPriority], classTag: classes[selectedClass])
        taskList.items.append(newTodo)
        newTodoTitle = ""
    }

//    private func getRandomHomework() {
//
//    }

    private func checkHomework(homework: Task) {
        taskList.toggleItemCompletion(homework)
    }

    private func deleteHomework(homework: Task) {
        taskList.deleteItem(homework)
    }

    var isFormValid: Bool {
        !newTodoTitle.isEmpty && selectedClass != 0
    }

    // Computes a dictionary with tasks grouped by due date
    private var groupedTasks: [Date: [Task]] {
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!
        let nextWeek = Calendar.current.date(byAdding: .day, value: 6, to: today)!

        let tasksByDueDate = Dictionary(grouping: taskList.items) { task in
            if Calendar.current.isDateInToday(task.dueDate) {
                return today
            } else if Calendar.current.isDateInTomorrow(task.dueDate) {
                return tomorrow
            } else if task.dueDate < nextWeek {
                return task.dueDate
            } else {
                return nextWeek
            }
        }

        return tasksByDueDate
    }
    
    

    // Computes a section title for a given due date
    private func dueDateSectionTitle(for dueDate: Date) -> String {
        let nextWeek = Calendar.current.date(byAdding: .day, value: 6, to: today)!

        if Calendar.current.isDateInToday(dueDate) {
            return "Due Today: "
        } else if Calendar.current.isDateInTomorrow(dueDate) {
            return "Due Tomorrow: "
        } else if dueDate < nextWeek {
            return "Due this " + dueDate.formatted(Date.FormatStyle().weekday(.wide))
        } else {
            return "Due next week(s): "
        }
    }
    
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        let taskList = TaskList()
        TodoListView().environmentObject(taskList)
    }
}

struct LeftTextSubtitle: View {
    var text: String

    var body: some View {
        HStack {
            Text(text)
            Spacer()
        }
    }
}
