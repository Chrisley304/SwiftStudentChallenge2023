import Foundation

class TodoList: ObservableObject {
    @Published var items: [TodoItem] = []
    
    func toggleItemCompletion(_ item: TodoItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].isCompleted.toggle()
        }
    }
    
    func deleteItem(_ item: TodoItem) {
        items.removeAll(where: { $0.id == item.id })
    }
}

struct TodoItem: Identifiable {
    let id = UUID()
    var title: String
    var isCompleted: Bool = false
}
