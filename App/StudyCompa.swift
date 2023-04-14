import SwiftUI

@main
struct StudyCompaApp: App {
    // Global Lists or variables for the control of the app (As Swift Playgrounds do not accept the use of DataModels)
    @StateObject private var taskList = TaskList()

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(taskList)
        }
    }
}
