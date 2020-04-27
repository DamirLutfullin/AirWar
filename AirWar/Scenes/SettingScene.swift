//
//  SettingScene.swift
//  AirWar
//
//  Created by Damir Lutfullin on 26.04.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import SpriteKit

class SettingScene: ParentScene {
    
    var isMusic : Bool!
    var isSounds : Bool!
    
    override func didMove(to view: SKView) {
            
        isMusic = gameSettings.isMusic
        isSounds = gameSettings.isSounds
        
        let backgroundForMusic = isMusic == true ? "music" : "nomusic"
        let backgroundForSounds = isSounds == true ? "sound" : "nosound"
        
           let background = Background(imageNamed: "camouflage")
           background.zPosition = 0
           background.anchorPoint = CGPoint(x: 0, y: 0)
           background.setScale(1.5)
           
           self.addChild(background)
           
           setHeader(name: "setting", background: "header_background")
           
           let buttonMusic = ButtonNode(title: "", backgroundNamed: backgroundForMusic)
           buttonMusic.position = CGPoint(x: self.frame.midX - 50,y: self.frame.midY)
           buttonMusic.zPosition = 1
           buttonMusic.name = "music"
           addChild(buttonMusic)
           
           let buttonSound = ButtonNode(title: "", backgroundNamed: backgroundForSounds)
           buttonSound.position = CGPoint(x: self.frame.midX + 50,y: self.frame.midY)
           buttonSound.zPosition = 1
           buttonSound.name = "sound"
           addChild(buttonSound)
        
            let backButton = ButtonNode(title: "back", backgroundNamed: "button_background")
            backButton.position = CGPoint(x: self.frame.midX,y: self.frame.midY - 150)
            backButton.zPosition = 1
            backButton.name = "back"
        backButton.label.name = "back"
        addChild(backButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first?.location(in: self)
        let node = self.atPoint(location!)
        let transition = SKTransition.crossFade(withDuration: 1)
        if node.name == "music" {
            isMusic = !isMusic
            update(node: node as! SKSpriteNode, property: isMusic)
        } else if node.name == "sound" {
            isSounds = !isSounds
            update(node: node as! SKSpriteNode, property: isSounds)
        } else if node.name == "back" {
            gameSettings.isSounds = isSounds
            gameSettings.isMusic = isMusic
            gameSettings.saveSettings()
            self.scene?.view?.presentScene(backScene!, transition: transition)
        }
    }
    
    func update(node: SKSpriteNode, property: Bool) {
        if let name = node.name {
            node.texture = property ? SKTexture(imageNamed: name) : SKTexture(imageNamed: "no" + name)
        }
    }
}
