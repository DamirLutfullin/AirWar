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
        
    }
}
