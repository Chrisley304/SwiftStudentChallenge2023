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

            if #available(iOS 16.0, *) {
                MyScoreView()
                    .tabItem {
                        Label("My Points", systemImage: "lanyardcard")
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
