//
//  pauseScene.swift
//  AirWar
//
//  Created by Damir Lutfullin on 25.04.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import SpriteKit

class PauseScene: SKScene {
    override func didMove(to view: SKView) {
       // self.backgroundColor = SKColor(red: 0.15, green: 0.15, blue: 0.3, alpha: 1)
        let background = Background(imageNamed: "camouflage")
        background.zPosition = 0
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.setScale(1.5)
        
        self.addChild(background)
        
        let header = ButtonNode(title: "Pause", backgroundNamed: "header_background")
        header.position = CGPoint(x: self.frame.midX,y: self.frame.height - 150)
        header.zPosition = 1
        self.addChild(header)
        
        let titles = ["restart", "settings", "resume"]
        
        for (index, title) in titles.enumerated() {
            let button = ButtonNode(title: title, backgroundNamed: "button_background")
            button.position = CGPoint(x: self.frame.midX,y: self.frame.midY - CGFloat(index + 1) * 100)
            button.zPosition = 1
            button.name = title
            button.label.name = title
            addChild(button)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first?.location(in: self)
        let node = self.atPoint(location!)
        let transition = SKTransition.crossFade(withDuration: 1)
        if node.name == "restart" {
            SceneManager.shared.scene = nil
            let scene = GameScene(size: self.size)
            scene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(scene, transition: transition)
        } else if node.name == "resume" {
            self.scene?.view?.presentScene(SceneManager.shared.scene!, transition: transition)
        }
    }
}
