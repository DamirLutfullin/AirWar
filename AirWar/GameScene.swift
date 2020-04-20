//
//  GameScene.swift
//  AirWar
//
//  Created by Damir Lutfullin on 18.04.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var player: PayerPlane!
   
    override func didMove(to view: SKView) {
        configureStartScene()
        backGroundGenerate(object: Cloud.self, pause: 3)
        backGroundGenerate(object: Island.self, pause: 2)
        player.performFly()
    }
    
    func configureStartScene() {
        let background = Background.background(at: self.anchorPoint)
        background.size = self.size
        self.addChild(background)
        player = PayerPlane.getSprite()
        self.addChild(player)
        
    }
    
    func backGroundGenerate(object: GameBackgroundSpritable.Type, pause: Int) {
        
        let pause = SKAction.wait(forDuration: TimeInterval(pause))
        let spawnObjects = SKAction.run {
            if object is Cloud.Type {
                let cloud = object as! Cloud.Type
                self.addChild(cloud.getSprite(at: nil))
            } else if object is Island.Type {
                let island = object as! Island.Type
                self.addChild(island.getSprite(at: nil))
            }
        }
        
        let spawnSequence = SKAction.sequence([pause, spawnObjects])
        let spawnSequenceForever = SKAction.repeatForever(spawnSequence)
        run(spawnSequenceForever)
        
    }
    
    override func didSimulatePhysics() {
        super.didSimulatePhysics()
        player.checkPosition()
        
        enumerateChildNodes(withName: "backgroundSprite") { (node, _) in
            if node.position.y < -190 {
                node.removeFromParent()
            }
        }
    }
}
