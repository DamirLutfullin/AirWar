//
//  MenuScene.swift
//  AirWar
//
//  Created by Damir Lutfullin on 24.04.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import SpriteKit

class MenuScene: ParentScene {
    override func didMove(to view: SKView) {
        self.scaleMode = .aspectFill
        if !Assets.shared.isLoaded {
            Assets.shared.preloadAssests()
            Assets.shared.isLoaded = true
        }
        //self.backgroundColor = SKColor(red: 0.15, green: 0.15, blue: 0.3, alpha: 1)
        let background = Background(imageNamed: "camouflage")
        background.zPosition = 0
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.setScale(1.5)
        
        self.addChild(background)
        
        setHeader(name: nil, background: "header1")
        
        let titles = ["play", "best", "settings"]
        
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
        if node.name == "play" {
            SceneManager.shared.scene = nil
            let transition = SKTransition.crossFade(withDuration: 1)
            let gameScene = GameScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(gameScene, transition: transition)
        } else if node.name == "settings" {
            let transition = SKTransition.crossFade(withDuration: 1)
            let settingScene = SettingScene(size: self.size)
            settingScene.scaleMode = .aspectFill
            settingScene.backScene = self
            self.scene?.view?.presentScene(settingScene, transition: transition)
        }
        
    }
}
