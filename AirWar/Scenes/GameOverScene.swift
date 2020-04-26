//
//  GameOverScene.swift
//  AirWar
//
//  Created by Damir Lutfullin on 26.04.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import SpriteKit

class GameOverScene: ParentScene {
       
        override func didMove(to view: SKView) {
            
            
            let background = Background(imageNamed: "camouflage")
            background.zPosition = 0
            background.anchorPoint = CGPoint(x: 0, y: 0)
            background.setScale(1.5)
            self.addChild(background)

            setHeader(name: nil, background: "header1")
            
            let button = ButtonNode(title: "game over", backgroundNamed: "header_background")
            button.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 150)
            button.zPosition = 1
            addChild(button)
            
            let titles = ["restart", "best", "settings", "menu"]
            
            for (index, title) in titles.enumerated() {
                let button = ButtonNode(title: title, backgroundNamed: "button_background")
                button.position = CGPoint(x: self.frame.midX,y: self.frame.midY - CGFloat(index + 1) * 90)
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
            } else if node.name == "menu" {
                let scene = MenuScene(size: self.size)
                self.scene?.view?.presentScene(scene, transition: transition)
            } else if node.name == "settings" {
                let transition = SKTransition.crossFade(withDuration: 1)
                let settingScene = SettingScene(size: self.size)
                settingScene.scaleMode = .aspectFill
                settingScene.backScene = self
                self.scene?.view?.presentScene(settingScene, transition: transition)
            } else if node.name == "best" {
                let transition = SKTransition.crossFade(withDuration: 1)
                let bestScene = BestScene(size: self.size)
                bestScene.scaleMode = .aspectFill
                bestScene.backScene = self
                self.scene?.view?.presentScene(bestScene, transition: transition)
            }
        }
    }
