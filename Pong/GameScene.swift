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
    
    var topLabel = SKLabelNode()
    var bottomLabel = SKLabelNode()
    
    var score = [Int]()

    
    /** did Move function
    **
    ** - Parameter view: function names variables within each SKSpriteNode
    **/
    override func didMove(to view: SKView) {
        
        //variables for ball, enemy bar, and main bar
        topLabel = self.childNode(withName: "topLabel") as! SKLabelNode
        bottomLabel = self.childNode(withName: "bottomLabel") as! SKLabelNode
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        
       print(self.view?.bounds.height)
        
        //positions frame for enemy
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        enemy.position.y = (self.frame.height / 2) - 50
        
        //positions frame for main player
        main = self.childNode(withName: "main") as! SKSpriteNode
        main.position.y = (-self.frame.height / 2) + 50
        
        //border of screen
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        
        //no friction
        border.friction = 0
        //enbles ball to bounce off the wall
        border.restitution = 1
        
        //border is the physics body to allow ball to bounce
        self.physicsBody = border
        startGame()
    }
    
    func startGame() {
        score = [0,0]
        topLabel.text = "\(score[1])"
        bottomLabel.text = "\(score[0])"
        //changes ball speed physics
        ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
    }
    
    /// adds Score to game
    ///
    /// - Parameter playerWhoWon: if enemy won when score is shown visa verca for player
    func addScore(playerWhoWon: SKSpriteNode) {
        
        //Places position of ball in center of screen once score is finished
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if playerWhoWon == main {
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
        }
        else if playerWhoWon == enemy {
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -10, dy: -10))
        }
        
        topLabel.text = "\(score[1])"
        bottomLabel.text = "\(score[0])"
    }
    /** Touch Began
       - Parameters:
       - touches: player touches screen
       - event: moves bar
    **/
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if currentGameType == .player2 {
                if location.y > 0 {
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                if location.y < 0 {
                    
                    main.run(SKAction.moveTo(x: location.x, duration: 0.2))
                    
                }
                
            }
            else{
                main.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
            
            
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
            //player 1 or 2 can move bar 
            if currentGameType == .player2 {
                if location.y > 0 {
                     enemy.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                if location.y < 0 {
                     main.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
            }
            else {
                main.run(SKAction.moveTo(x: location.x, duration: 0.2))
                
            }
        }
    }
    
       /** Update
        - Parameter time interval for how fast the ball moves with each difficulty level
       **/
       override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        switch currentGameType {
        case .easy:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.3))
            break
        case .medium:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.0))
            break
        case .hard:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.7))
            break
        case .player2:
            break
        }
        
        if ball.position.y <= main.position.y - 30 {
            addScore(playerWhoWon: enemy)
        }
        
        else if ball.position.y >= enemy.position.y + 30 {
            addScore(playerWhoWon: main)
            
        }
    }
}
