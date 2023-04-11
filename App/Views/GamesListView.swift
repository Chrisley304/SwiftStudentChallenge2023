//
//  SwiftUIView.swift
//  
//
//  Created by Christian Leyva on 09/04/23.
//

import SwiftUI
import SpriteKit

struct GamesListView: View {
    var body: some View {
        NavigationView {
            List{
                NavigationLink{
                    SpriteView(scene: TasksBreakGameScene()).ignoresSafeArea()
                } label: {
                    Text("Tasks Break 💥")
                }
                
            }
            .navigationTitle("Games")
        }
    }
}

struct GamesListView_Previews: PreviewProvider {
    static var previews: some View {
        GamesListView()
    }
}
