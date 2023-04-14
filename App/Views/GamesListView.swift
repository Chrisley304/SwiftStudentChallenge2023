//
//  SwiftUIView.swift
//
//
//  Created by Christian Leyva on 09/04/23.
//

import SpriteKit
import SwiftUI

struct GamesListView: View {
    @State private var initiateTaskBreakGame = false

    var body: some View {
        //                SpriteView(scene: TasksBreakGameScene()).ignoresSafeArea()
        NavigationView {
            List {
                Button("Tasks Break 💥") {
                    initiateTaskBreakGame.toggle()
                }.fullScreenCover(isPresented: $initiateTaskBreakGame) {
                    ZStack {
                        SpriteView(scene: TasksBreakGameScene()).ignoresSafeArea()
                        Button(action: {
                            initiateTaskBreakGame.toggle()
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundColor(.gray)
                        }
                        .position(x: UIScreen.main.bounds.width - 30, y: 30)
    //                    .position(x:20,y:20)
    //                    .offset(x: -5, y: -5)
                    }
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
