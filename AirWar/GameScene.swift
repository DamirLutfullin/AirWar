//
//  GameScene.swift
//  AirWar
//
//  Created by Damir Lutfullin on 18.04.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene {
    
    var player: SKSpriteNode!
    let motionManager = CMMotionManager()
    var xAcceleration: CGFloat = 0
    
    override func didMove(to view: SKView) {
        
        let background = Background.background(at: self.anchorPoint)
        background.size = self.size
        self.addChild(background)
        
        let screen = UIScreen.main.bounds
        
        for _ in 0...5 {
            let x = CGFloat.random(in: 0...screen.size.width)
            let y = CGFloat.random(in: 0...screen.size.height)
            
            let island = Island.getIsland(at: CGPoint(x: x, y: y))
            let cloud = Cloud.getCloud(at: CGPoint(x: x, y: y))
            
            self.addChild(island)
            self.addChild(cloud)
        }
        
        player = PayerPlane.getPlain(at: CGPoint(x: screen.width / 2, y: 100))
        self.addChild(player)
        
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
            if let data = data {
                let acceleration = data.acceleration
                self.xAcceleration = CGFloat(acceleration.x) * 0.7 + self.xAcceleration * 0.3
            }
        }
    }
    
    override func didSimulatePhysics() {
        super.didSimulatePhysics()
        player.position.x = self.xAcceleration * 50
        
        if player.position.x < -70 {
            player.position.x = self.size.width + 70
        } else if player.position.x > self.size.width + 70 {
            player.position.x = -70
        }
    }
}
