import SwiftUI
import Foundation
import SpriteKit

class TasksBreakGameOverScene: SKScene{
    
    let gameOverLabel = SKLabelNode(text: "GAME OVER")
    
    override func didMove(to view: SKView) {
        gameOverLabel.fontName = "Helvetica"
        gameOverLabel.fontSize = 20
        gameOverLabel.fontColor = .red
        gameOverLabel.horizontalAlignmentMode = .center
        gameOverLabel.verticalAlignmentMode = .center
        backgroundColor = .systemBlue
        
        gameOverLabel.position = CGPoint(x: size.width/2, y: size.height / 2)
        gameOverLabel.setScale(1.5)
        gameOverLabel.zPosition = 5
        addChild(gameOverLabel)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let scene = TasksBreakGameScene(size: self.size)
        let transition = SKTransition.flipVertical(withDuration: 2)
        
        self.view?.presentScene(scene, transition: transition)
    }
}
