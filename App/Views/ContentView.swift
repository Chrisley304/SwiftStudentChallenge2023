import SwiftUI

struct ContentView: View {
    
    // Global Lists or variables for the control of the app (As Swift Playgrounds do not accept the use of DataModels)
    @StateObject private var taskList = TaskList()
    
    var body: some View {
        TabView {
            TodoListView()
                .tabItem {
                    Label("Homeworks", systemImage: "text.book.closed.fill")
                }
                .environmentObject(taskList)
            
            GamesListView()
                .tabItem {
                    Label("Games", systemImage: "gamecontroller")
                }

            FunFactsView()
                .tabItem {
                    Label("Points", systemImage: "lanyardcard")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
