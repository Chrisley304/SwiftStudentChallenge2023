import SwiftUI

struct ContentView: View {
        
    var body: some View {
        TabView {
            TodoListView()
                .tabItem {
                    Label("Homeworks", systemImage: "text.book.closed.fill")
                }
                
            
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
