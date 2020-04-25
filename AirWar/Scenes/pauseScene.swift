//
//  pauseScene.swift
//  AirWar
//
//  Created by Damir Lutfullin on 25.04.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import SpriteKit

class PauseScene: ParentScene {
    
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
        
        let titles = ["restart", "settings", "resume", "menu"]
        
        for (index, title) in titles.enumerated() {
            let button = ButtonNode(title: title, backgroundNamed: "button_background")
            button.position = CGPoint(x: self.frame.midX,y: self.frame.midY - CGFloat(index * 100))
            button.zPosition = 1
            button.name = title
            button.label.name = title
            addChild(button)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if let gameScene = SceneManager.shared.scene {
            if !gameScene.isPaused {
                gameScene.isPaused = true
            }
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
        } else if node.name == "menu" {
            let scene = MenuScene(size: self.size)
            self.scene?.view?.presentScene(scene, transition: transition)
        } else if node.name == "settings" {
            let transition = SKTransition.crossFade(withDuration: 1)
            let settingScene = SettingScene(size: self.size)
            settingScene.scaleMode = .aspectFill
            settingScene.backScene = self
            self.scene?.view?.presentScene(settingScene, transition: transition)
        } 
    }
}
