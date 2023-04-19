//
//  GamesListView.swift
//
//
//  Created by Christian Leyva on 09/04/23.
//

import SpriteKit
import SwiftUI

struct GamesListView: View {
    @EnvironmentObject var taskList: TaskList

    var body: some View {
        NavigationView {
            List {
                GamesListItem(gameTitle: "Tasks Breaker", gameDescription: "Destroy your accomplished tasks!" , gameImage: "BrickBreaker", isLocked: isTasksBreakerLocked, gameScene: tasksBreakGame)
            }
            .navigationTitle("Games")
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    var tasksBreakGame: SKScene {
        let filteredHomeworks = taskList.items.filter{$0.isCompleted} // Returns a list (titles) of homeworks finished
        let scene = TasksBreakGameScene(size: .init(), tasksList: filteredHomeworks)
        scene.stoneCounter = 0
        return scene
    }
    
    var isTasksBreakerLocked: Bool {
        return taskList.studentPoints < 50
    }
}

struct GamesListView_Previews: PreviewProvider {
    static var previews: some View {
        var taskList: TaskList {
            let tasks = TaskList(studentPoints: 50)
            tasks.items.append(Homework(title: "TEST", dueDate: Date(), priority: Priority(id: 1, name: "", color: .black), classTag: HomeworkClass(id: 0, title: "", color: .accentColor), order: 0))
            return tasks
        }
        GamesListView().environmentObject(taskList)
    }
}
