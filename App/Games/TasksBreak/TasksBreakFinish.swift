import SwiftUI
import Foundation
import SpriteKit

class TasksBreakFinishScene: SKScene{
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        
        let label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = "Level Finished"
        label.fontColor = .red
        label.fontSize = 45
        label.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(label)
    }
    
}
