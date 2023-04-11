import SwiftUI
import SpriteKit
import GameKit

class TasksBreakGameScene: SKScene, SKPhysicsContactDelegate{
    
//    let background = SKSpriteNode(imageNamed: "bg_layer3")
    let paddel = SKSpriteNode(color: .blue, size: CGSize(width: 150, height: 15))
//    let ball = SKSpriteNode(imageNamed: "ballBlue")
    let ball = SKShapeNode()
    
    var stoneCounter = 0
    
    enum bitmasks: UInt32{
        case frame = 0b1 // 1
        case paddel = 0b10 //2
        case box = 0b100 // 4
        case ball = 0b1000 //8
    }
    
    override func didMove(to view: SKView) {
        scene?.size = view.bounds.size
        scene?.scaleMode = .aspectFill
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        self.isPaused = true
        
        physicsWorld.contactDelegate = self
        
        // Background
//        background.position = CGPoint(x: size.width / 2, y: size.height/2)
//        background.zPosition = 1
//        background.setScale(0.65)
//        addChild(background)
        
//        backgroundColor = .gray
        
        
        // Player
        paddel.position = CGPoint(x: size.width / 2, y: 25)
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
        let circlePath = CGPath(ellipseIn: CGRect(x: 0, y: 0, width: 30, height: 30), transform: nil)
        ball.path = circlePath
        ball.fillColor = .red
        ball.strokeColor = .clear
        ball.position.x = paddel.position.x
        ball.position.y = paddel.position.y + 30
        ball.zPosition = 10
        ball.physicsBody = SKPhysicsBody (circleOfRadius: 25 / 2)
        ball.physicsBody?.friction = 0
        ball.physicsBody?.restitution = 1
        ball.physicsBody?.linearDamping = 0
        ball.physicsBody?.angularDamping = 0
        ball.physicsBody?.allowsRotation = false
        ball.physicsBody?.categoryBitMask = bitmasks.ball.rawValue
        ball.physicsBody?.contactTestBitMask = bitmasks.paddel.rawValue | bitmasks.frame.rawValue | bitmasks.box.rawValue
        ball.physicsBody?.collisionBitMask = bitmasks.paddel.rawValue | bitmasks.frame.rawValue | bitmasks.box.rawValue
        
        addChild (ball)
        
        ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: -10))
        
        // Frame
        let frame = SKPhysicsBody (edgeLoopFrom: self.frame)
        frame.friction = 0
        frame.categoryBitMask = bitmasks.frame.rawValue
        frame.contactTestBitMask = bitmasks.ball.rawValue
        frame.collisionBitMask = bitmasks.ball.rawValue
        self.physicsBody = frame
        
        // Stones
        
        makeStones(reihe: 4, bitmask: 0b100, y: Int(size.height) - 200)
        makeStones(reihe: 4, bitmask: 0b100, y: Int(size.height) - 250)
        makeStones(reihe: 4, bitmask: 0b100, y: Int(size.height) - 300)
        
        // 33 Stones
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            paddel.position.x = location.x
            
            if isPaused == true{
                ball.position.x = location.x   
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isPaused = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
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
    
    func makeStones(reihe: Int, bitmask: UInt32, y: Int){
        for i in 1...reihe{
            
            let box = SKShapeNode(rectOf: CGSize(width: 100, height: 50))
            box.fillColor = .white
            box.strokeColor = .black
            box.name = "Box"+String(i)
            box.position = CGPoint(x: 0 + i*100, y: y)
            box.zPosition = 10
            
            let label = SKLabelNode(text: "Equations 📏")
            label.fontName = "Helvetica"
            label.fontSize = 14
            label.fontColor = .black
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
            if stoneCounter == 12{
                finishGame()
            }
        }
        
        if contactA.categoryBitMask == bitmasks.paddel.rawValue && contactB.categoryBitMask == bitmasks.ball.rawValue{
            if contactB.node!.position.x <= contactA.node!.frame.midX-5{
                contactB.node?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                contactB.node?.physicsBody?.applyImpulse(CGVector(dx: -10, dy: 10))
            }
            if contactB.node!.position.x <= contactA.node!.frame.midX+5{
                contactB.node?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                contactB.node?.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
            }
        }
        
        if contactA.categoryBitMask == bitmasks.frame.rawValue && contactB.categoryBitMask == bitmasks.ball.rawValue{
            let yPos = contact.contactPoint.y
            
            if yPos <= self.frame.minY + 10 {
                gameOver()
            }
        }
        
    }
    
    func gameOver(){
        let gameOverScene = TasksBreakGameOverScene(size: self.size)
        let transition = SKTransition.flipHorizontal(withDuration: 2)
        
        self.view?.presentScene(gameOverScene, transition: transition) 
    }
    
    func finishGame(){
        let finishScene = TasksBreakFinishScene(size: self.size)
        let transition = SKTransition.doorsCloseHorizontal(withDuration: 2)
        
        self.view?.presentScene(finishScene, transition: transition)
    }
    
}
