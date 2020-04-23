//
//  MenuScene.swift
//  AirWar
//
//  Created by Damir Lutfullin on 24.04.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor.lightGray
        let texture = SKTexture(imageNamed: "play")
        let button = SKSpriteNode(texture: texture)
        button.position = CGPoint(x: self.frame.midX,y: self.frame.midY)
        button.name = "runButton"
        button.setScale(2)
        self.addChild(button)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first?.location(in: self)
        let node = self.atPoint(location!)
        if node.name == "runButton" {
            let transition = SKTransition.crossFade(withDuration: 1)
            let gameScene = GameScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            
            self.scene?.view?.presentScene(gameScene, transition: transition)
        }
        
    }
}
