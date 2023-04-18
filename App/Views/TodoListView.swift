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
    @State private var randomHomework: Homework = Homework(title: "", priority: Priority(id: -1, name: "", color: .yellow), classTag: HomeworkClass(id: 0, title: "Class", color: .gray), order: 0)
    private var classes = [HomeworkClass(id: 0, title: "Class", color: .gray), HomeworkClass(id:1, title: "Math 📏", color: .blue, textColor: .white) , HomeworkClass(id:2, title: "Biology 🌱", color: .green) , HomeworkClass(id: 3, title: "Spanish", color: .red), HomeworkClass(id:4, title: "English", color: .blue), HomeworkClass(id:5, title: "History 📚", color: .brown)]
    @State private var selectedClass = 0
    private var priorities = [Priority(id: 0, name: "High 🚨", color: .red, textColor: .white), Priority(id: 1, name: "Medium ⚠️", color: .yellow), Priority(id: 2, name: "Low ✌🏼", color: .green, textColor: .white)]
    @State private var selectedPriority = 0
    @State public var showHomeworkModal = false
    @State private var showIntro = true

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
                            if getUncompletedTasks(tasks: groupedTasks[dueDate]!).count > 1{
                                Button("Give me a homework"){
                                    let unCompletedTasks = getUncompletedTasks(tasks: groupedTasks[dueDate]!)
                                    let randomHomeworkIndex = Int.random(in: 0..<unCompletedTasks.count)
                                    randomHomework = unCompletedTasks[randomHomeworkIndex]
                                    showHomeworkModal.toggle()
                                }
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
                ToolbarItem(placement: .navigationBarLeading){
                    Button {
                        showIntro.toggle()
                    } label: {
                        Image(systemName: "questionmark.circle")
                    }
                }
            }
            .popup(isPresented: showHomeworkModal){
                HomeworkModalCard(title: randomHomework.title, homeworkClass: randomHomework.classTag , showHomeworkModal: $showHomeworkModal)
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
                            
                            HStack{
                                Text("Priority:")
                                Spacer()
                            }
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
                        
                        .presentationDetents([.fraction(0.5)])
                    }.padding(.horizontal)
                } else {
                    Text("TODO: ADD THE SAME Vstack")
                }
            }
        }.fullScreenCover(isPresented: $showIntro){
            IntroView(isShown: $showIntro)
        }
            
    }

    private func addNewTodo() {
        guard !newTodoTitle.isEmpty else { return }
        let newTodo = Homework(title: newTodoTitle, dueDate: newHomeworkDate, priority: priorities[selectedPriority], classTag: classes[selectedClass], order: priorities[selectedPriority].id)
        taskList.items.append(newTodo)
        newTodoTitle = ""
    }

    private func checkHomework(homework: Homework) {
        taskList.toggleItemCompletion(homework)
    }

    private func deleteHomework(homework: Homework) {
        taskList.deleteItem(homework)
    }

    var isFormValid: Bool {
        !newTodoTitle.isEmpty && selectedClass != 0
    }
    
    private func getUncompletedTasks(tasks: [Homework]) -> [Homework]{
        return tasks.filter{!$0.isCompleted}
    }

    // Computes a dictionary with tasks grouped by due date
    private var groupedTasks: [Date: [Homework]] {
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
        }.mapValues { tasks in
            tasks.sorted { $0.order < $1.order } // Sort by order property of Task Object
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
