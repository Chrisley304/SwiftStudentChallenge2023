//
//  SwiftUIView.swift
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
        }
    }
    
    var tasksBreakGame: SKScene {
        let scene = TasksBreakGameScene()
        scene.tasksList = taskList.items.filter{$0.isCompleted}.map{$0.title} // Returns a list (titles) of homeworks finished
        return scene
    }
    
    var isTasksBreakerLocked: Bool {
        return taskList.studentPoints < 50
    }
}

struct GamesListView_Previews: PreviewProvider {
    static var previews: some View {
        let taskList = TaskList(studentPoints: 50)
        GamesListView().environmentObject(taskList)
    }
}
