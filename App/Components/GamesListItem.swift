//
//  SwiftUIView.swift
//  
//
//  Created by Christian Leyva on 15/04/23.
//

import SwiftUI
import SpriteKit

struct GamesListItem: View {
    
    let gameTitle: String
    let gameDescription : String
    let gameImage: String
    let isLocked: Bool
    @State private var initGame = false
    let gameScene : SKScene
    
    var body: some View {
        HStack {
            Image(gameImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
            
            VStack {
                HStack {
                    Text(gameTitle)
                        .font(.headline)
                    Spacer()
                }
                HStack {
                    Text(gameDescription).font(.footnote)
                    Spacer()
                }
            }
            
            if isLocked {
                Spacer()
                Image(systemName: "lock.fill")
                    .foregroundColor(.red)
                Text("Locked until 50 points")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            } else {
                Spacer()
                Text("Play")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Image(systemName: "play.circle.fill")
                    .foregroundColor(.green)
            }
        }.onTapGesture {
            initGame.toggle()
        }.fullScreenCover(isPresented: $initGame) {
            ZStack {
                SpriteView(scene: gameScene).ignoresSafeArea()
                Button(action: {
                    initGame.toggle()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                        .foregroundColor(.gray)
                }
                .position(x: UIScreen.main.bounds.width - 30, y: 30)
            }
        }.disabled(isLocked)
    }
}

struct GamesListItem_Previews: PreviewProvider {
    static var previews: some View {
        List {
            GamesListItem(gameTitle: "TaskBreaker", gameDescription: "Destroy your tasks!",  gameImage: "BrickBreaker", isLocked: false, gameScene: TasksBreakGameScene())
        }
    }
}
