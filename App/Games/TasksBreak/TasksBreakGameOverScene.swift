import SwiftUI
import Foundation
import SpriteKit

class TasksBreakGameOverScene: SKScene{
    
    let gameOverLabel = SKLabelNode(text: "GAME OVER")
    var homeworkCount: Int
    let homeworksList: [Homework]
    
    init(size: CGSize, homeworkCount: Int, homeworksList: [Homework]) {
        self.homeworkCount = homeworkCount
        self.homeworksList = homeworksList
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        let homeworksHitLabel = SKLabelNode(text: "You hit \(homeworkCount) homeworks!")
        homeworksHitLabel.fontName = "Helvetica"
        homeworksHitLabel.fontSize = 20
        homeworksHitLabel.fontColor = .white
        homeworksHitLabel.horizontalAlignmentMode = .center
        homeworksHitLabel.verticalAlignmentMode = .center
        homeworksHitLabel.position = CGPoint(x: size.width/2, y: size.height / 2 + 50)
        addChild(homeworksHitLabel)
        
        gameOverLabel.fontName = "Helvetica"
        gameOverLabel.fontSize = 30
        gameOverLabel.fontColor = .red
        gameOverLabel.horizontalAlignmentMode = .center
        gameOverLabel.verticalAlignmentMode = .center
        gameOverLabel.position = CGPoint(x: size.width/2, y: size.height / 2)
        gameOverLabel.setScale(1.5)
        gameOverLabel.zPosition = 5
        addChild(gameOverLabel)
        
        let retryLabel = SKLabelNode(text: "Touch the screen to retry")
        retryLabel.fontName = "Helvetica"
        retryLabel.fontSize = 20
        retryLabel.fontColor = .white
        retryLabel.horizontalAlignmentMode = .center
        retryLabel.verticalAlignmentMode = .center
        retryLabel.position = CGPoint(x: size.width/2, y: size.height / 2 - 50)
        addChild(retryLabel)
        
        backgroundColor = .black
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let scene = TasksBreakGameScene(size: self.size, tasksList: homeworksList)
        let transition = SKTransition.flipVertical(withDuration: 2)
        
        self.view?.presentScene(scene, transition: transition)
    }
}
