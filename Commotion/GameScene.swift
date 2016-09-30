//
//  GameScene.swift
//  Assignment3Game
//
//  Created by Jenn Le on 9/28/16.
//  Copyright © 2016 Thakugan. All rights reserved.
//

import Foundation
import SpriteKit
import CoreMotion

class GameScene: SKScene {
    private var lastUpdateTime : TimeInterval = 0
    
    // MARK: Raw Motion Functions
    let motion = CMMotionManager()
    func startMotionUpdates(){
        // some internal inconsistency here: we need to ask the device manager for device
        
        if self.motion.isDeviceMotionAvailable{
            self.motion.deviceMotionUpdateInterval = 0.1
            self.motion.startDeviceMotionUpdates(to: OperationQueue.main, withHandler: self.handleMotion as! CMDeviceMotionHandler)
        }
    }
    
    func handleMotion(_ motionData:CMDeviceMotion?, error:NSError?){
        if let gravity = motionData?.gravity {
            self.physicsWorld.gravity = CGVector(dx: CGFloat(9.8*gravity.x), dy: CGFloat(9.8*gravity.y))
        }
    }
    
    // MARK: View Hierarchy Functions
    override func didMove(to view: SKView) {
        
        backgroundColor = SKColor.white
        
        // start motion for gravity
        self.startMotionUpdates()
        
        // make sides to the screen
        self.addAllSides()
        
        self.spawnBall()
        self.spawnGoal()
    }
    
    override func sceneDidLoad() {
        self.lastUpdateTime = 0
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        self.lastUpdateTime = currentTime
    }
    
    func addAllSides(){
        let left = SKSpriteNode()
        let right = SKSpriteNode()
        let top = SKSpriteNode()
        let bottom = SKSpriteNode()
        
        left.size = CGSize(width:size.width*0.01,height:size.height)
        left.position = CGPoint(x:0, y:size.height*0.5)
        
        right.size = CGSize(width:size.width*0.01,height:size.height)
        right.position = CGPoint(x:size.width, y:size.height*0.5)
        
        top.size = CGSize(width:size.width,height:size.height*0.01)
        top.position = CGPoint(x:size.width*0.5, y:size.height)
        
        bottom.size = CGSize(width:size.width,height:size.height*0.01)
        bottom.position = CGPoint(x:size.width*0.5, y:0)
        
        for obj in [left,right,top, bottom]{
            obj.color = UIColor.black
            obj.physicsBody = SKPhysicsBody(rectangleOf:obj.size)
            obj.physicsBody?.isDynamic = true
            obj.physicsBody?.pinned = true
            obj.physicsBody?.allowsRotation = false
            self.addChild(obj)
        }
    }
    
    func spawnBall() {
        let ball = SKSpriteNode(imageNamed: "ballSprite")
        
        let ballSize = size.height * 0.1
        ball.size = CGSize(width:ballSize,height:ballSize)
        
        ball.position = CGPoint(x: size.width * 0.50, y: size.height * 0.25)
        
        ball.physicsBody = SKPhysicsBody(rectangleOf:ball.size)
        ball.physicsBody?.isDynamic = true
        
        self.addChild(ball)
    }
    
    func spawnGoal() {
        let hole = SKSpriteNode(imageNamed: "holeSprite")
        
        let holeSize = size.height * 0.1
        hole.size = CGSize(width:holeSize,height:holeSize)
        
        //ensures the goal is not spawned at the same height as the ball
        var randY = CGFloat(drand48())
        while randY == 0.25 {
            randY = CGFloat(drand48())
        }
        hole.position = CGPoint(x: size.width * CGFloat(drand48()), y: size.height * 0.25)
        
        hole.physicsBody = SKPhysicsBody(rectangleOf:hole.size)
        hole.physicsBody?.isDynamic = true
        hole.physicsBody?.pinned = true
        
        self.addChild(hole)
    }
}
