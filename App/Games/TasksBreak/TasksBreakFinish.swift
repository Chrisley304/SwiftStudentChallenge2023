import SwiftUI
import Foundation
import SpriteKit

class TasksBreakFinishScene: SKScene{
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        
        var label = SKLabelNode(fontNamed: "Helvetica")
        label.text = "You hitted all your homeworks!"
        label.fontColor = .green
        label.fontSize = 20
        label.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(label)
        
        label = SKLabelNode(fontNamed: "Helvetica")
        label.text = "Keep working hard 💪🏼"
        label.fontColor = .green
        label.fontSize = 20
        label.position = CGPoint(x: size.width/2, y: size.height/2 - 50)
        addChild(label)
        
        label = SKLabelNode(fontNamed: "Helvetica")
        label.text = "Touch the close button at the top to close the game. ⬆"
        label.fontColor = .white
        label.fontSize = 15
        label.position = CGPoint(x: size.width/2, y: size.height/2 - 100)
        addChild(label)
    }
    
}
