//
//  GameScene.swift
//  Pong
//
//  Created by Auriel on 3/6/17.
//  Copyright © 2017 Sphexis. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main = SKSpriteNode()
    
    /** did Move function
    **
    ** - Parameter view: function names variables within each SKSpriteNode
    **/
    override func didMove(to view: SKView) {
        //variables for ball, enemy bar, and main bar
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        main = self.childNode(withName: "main") as! SKSpriteNode
        
        
        //launches ball at a 45 degree angle
        ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
        
        //border of screen
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        
        //no friction
        border.friction = 0
        //enbles ball to bounce off the wall
        border.restitution = 1
        
        //border is the physics body to allow ball to bounce
        self.physicsBody = border
           }
    
    /** Touch Began
       - Parameters:
       - touches: player touches screen
       - event: moves bar
    **/
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            main.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
    
    /** Touch moved
       - Parameters:
       - touches: when player's finger starts to move the bar
       - event: bar moves with players finger
    **/
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            main.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
    
       /** Update
        - Parameter currentTime: enemy bar moves when ball is bouncing towards it.
       **/
       override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.0))
    }
}
