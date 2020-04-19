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
    
    override func didMove(to view: SKView) {
        
        let sprite = SKSpriteNode(color: .green, size: self.size)
        
        self.addChild(sprite)
        

    }
}
