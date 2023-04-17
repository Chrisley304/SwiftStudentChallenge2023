import SwiftUI
import SpriteKit
import GameKit

class TasksBreakGameScene: SKScene, SKPhysicsContactDelegate{
    
    let paddel = SKSpriteNode(color: .blue, size: CGSize(width: 120, height: 15))
    let ball = SKShapeNode()
    
    let tasksList: [Homework]
    
    var stoneCounter = 0
    let boxWidth = 100
    let boxHeight = 30
    var ballVelocity = 15
    
    
    enum bitmasks: UInt32{
        case frame = 0b1 // 1
        case paddel = 0b10 //2
        case box = 0b100 // 4
        case ball = 0b1000 //8
    }
    
    init(size: CGSize, tasksList: [Homework]) {
        self.tasksList = tasksList
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        scene?.size = view.bounds.size
        scene?.scaleMode = .aspectFill
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        self.isPaused = true
        backgroundColor = .systemBackground
        
        physicsWorld.contactDelegate = self
        
        // Player
        paddel.position = CGPoint(x: size.width / 2, y: 40)
        paddel.zPosition = 10
        paddel.physicsBody = SKPhysicsBody(rectangleOf: paddel.size)
        paddel.physicsBody?.allowsRotation = false
        paddel.physicsBody?.restitution = 1
        paddel.physicsBody?.isDynamic = false
        paddel.physicsBody?.categoryBitMask = bitmasks.paddel.rawValue
        paddel.physicsBody?.contactTestBitMask = bitmasks.ball.rawValue
        paddel.physicsBody?.collisionBitMask = bitmasks.ball.rawValue
        addChild(paddel)
        
        // Ball
        let circlePath = CGPath(ellipseIn: CGRect(x: 0, y: 0, width: 25, height: 25), transform: nil)
        ball.path = circlePath
        ball.fillColor = .red
        ball.strokeColor = .clear
        ball.position.x = paddel.position.x
        ball.position.y = paddel.position.y + 30
        ball.zPosition = 10
        ball.physicsBody = SKPhysicsBody (circleOfRadius: 30 / 2)
        ball.physicsBody?.friction = 0
        ball.physicsBody?.restitution = 1
        ball.physicsBody?.linearDamping = 0
        ball.physicsBody?.angularDamping = 0
        ball.physicsBody?.allowsRotation = false
        ball.physicsBody?.categoryBitMask = bitmasks.ball.rawValue
        ball.physicsBody?.contactTestBitMask = bitmasks.paddel.rawValue | bitmasks.frame.rawValue | bitmasks.box.rawValue
        ball.physicsBody?.collisionBitMask = bitmasks.paddel.rawValue | bitmasks.frame.rawValue | bitmasks.box.rawValue
        
        addChild (ball)
        
        ball.physicsBody?.applyImpulse(CGVector(dx: ballVelocity, dy: ballVelocity))
        
        // Frame
        let frame = SKPhysicsBody(edgeLoopFrom: self.frame)
        frame.friction = 0
        frame.categoryBitMask = bitmasks.frame.rawValue
        frame.contactTestBitMask = bitmasks.ball.rawValue
        frame.collisionBitMask = bitmasks.ball.rawValue
        self.physicsBody = frame
        
        // Stones
        
        createBlocks(n: 3, bitmask: 0b100, y: Int(size.height) - 100)
        createBlocks(n: 3, bitmask: 0b100, y: Int(size.height) - 100 - (1*boxHeight))
        createBlocks(n: 3, bitmask: 0b100, y: Int(size.height) - 100 - (2*boxHeight))
        createBlocks(n: 3, bitmask: 0b100, y: Int(size.height) - 100 - (3*boxHeight))
        createBlocks(n: 3, bitmask: 0b100, y: Int(size.height) - 100 - (4*boxHeight))
        
        // 33 Stones
        
    }
    
    func getRandomHomeworkIndex() -> Int{
        return Int.random(in: 0...((tasksList.count - 1) ))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            paddel.position.x = location.x
            
            if isPaused == true{
                ball.position.x = location.x
                stoneCounter = 0
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isPaused = false
    }
    
    override func update ( _ currentTime: TimeInterval) {
        if paddel.position.x < 50 {
            paddel.position.x = 50
        }
        if paddel.position.x > self.size.width - paddel.size.width / 2 {
            paddel.position.x = self.size.width - paddel.size.width / 2
        }
    }
    
    func createBlocks(n: Int, bitmask: UInt32, y: Int){
        for i in 1...n{
            
            let randomHomework = tasksList[self.getRandomHomeworkIndex()]
            let box = SKShapeNode(rectOf: CGSize(width: boxWidth, height: boxHeight))
            box.fillColor = UIColor(randomHomework.classTag.color)
            box.strokeColor = .black
            box.name = "Box"+String(i)
            box.position = CGPoint(x: 0 + (i*boxWidth), y: y)
            box.zPosition = 10
            
            let label = SKLabelNode(text: randomHomework.title)
            label.fontName = "Helvetica"
            label.fontSize = 12
            label.fontColor = UIColor(randomHomework.classTag.textColor)
            label.horizontalAlignmentMode = .center
            label.verticalAlignmentMode = .center
            
            box.addChild(label)
            
            box.physicsBody = SKPhysicsBody(edgeChainFrom: box.path!)
            box.physicsBody?.friction = 0
            box.physicsBody?.allowsRotation = false
            box.physicsBody?.restitution = 1
            box.physicsBody?.isDynamic = false
            box.physicsBody?.categoryBitMask = bitmasks.box.rawValue
            box.physicsBody?.contactTestBitMask = bitmasks.ball.rawValue
            box.physicsBody?.collisionBitMask = bitmasks.ball.rawValue
            addChild(box)
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contactA: SKPhysicsBody
        let contactB: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            contactA = contact.bodyA
            contactB = contact.bodyB // ball
        } else {
            contactA = contact.bodyB
            contactB = contact.bodyA // ball
        }
        if contactA.categoryBitMask == bitmasks.box.rawValue && contactB.categoryBitMask == bitmasks.ball.rawValue {
            contactA.node?.removeFromParent()
            stoneCounter += 1
            
            // Score board
            if stoneCounter == 15{
                finishGame()
            }
            
            // Add impulse to the ball when the user get 5 points
            if stoneCounter == 5{
                ballVelocity += 1
                ball.physicsBody?.applyImpulse(CGVector(dx: ballVelocity, dy: ballVelocity))
            }else if stoneCounter == 10 {
                ballVelocity += 1
                ball.physicsBody?.applyImpulse(CGVector(dx: ballVelocity, dy: ballVelocity))
            }
            
        }
        
        if contactA.categoryBitMask == bitmasks.paddel.rawValue && contactB.categoryBitMask == bitmasks.ball.rawValue{
            if contactB.node!.position.x <= contactA.node!.frame.midX-5{
                contactB.node?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                contactB.node?.physicsBody?.applyImpulse(CGVector(dx: -ballVelocity, dy: ballVelocity))
            }
            if contactB.node!.position.x <= contactA.node!.frame.midX+5{
                contactB.node?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                contactB.node?.physicsBody?.applyImpulse(CGVector(dx: ballVelocity, dy: ballVelocity))
            }
        }
        
        if contactA.categoryBitMask == bitmasks.frame.rawValue && contactB.categoryBitMask == bitmasks.ball.rawValue{
            let yPos = contact.contactPoint.y
            
            if yPos <= self.frame.minY + 20 {
                gameOver()
            }
        }
        
    }
    
    func gameOver(){
        let gameOverScene = TasksBreakGameOverScene(size: self.size, homeworkCount: self.stoneCounter, homeworksList: tasksList)
        let transition = SKTransition.fade(with: .red, duration: 2)
        
        self.view?.presentScene(gameOverScene, transition: transition) 
    }
    
    func finishGame(){
        let finishScene = TasksBreakFinishScene(size: self.size)
        let transition = SKTransition.reveal(with: .down, duration: 2)
        
        self.view?.presentScene(finishScene, transition: transition)
    }
    
}
