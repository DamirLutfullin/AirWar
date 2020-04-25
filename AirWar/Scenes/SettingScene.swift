//
//  SettingScene.swift
//  AirWar
//
//  Created by Damir Lutfullin on 26.04.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import SpriteKit

class SettingScene: ParentScene {
    
    override func didMove(to view: SKView) {
        
           let background = Background(imageNamed: "camouflage")
           background.zPosition = 0
           background.anchorPoint = CGPoint(x: 0, y: 0)
           background.setScale(1.5)
           
           self.addChild(background)
           
           setHeader(name: "setting", background: "header_background")
           
           let buttonMusic = ButtonNode(title: "", backgroundNamed: "music")
           buttonMusic.position = CGPoint(x: self.frame.midX - 50,y: self.frame.midY)
           buttonMusic.zPosition = 1
           buttonMusic.name = "music"
           addChild(buttonMusic)
           
           let buttonSound = ButtonNode(title: "", backgroundNamed: "sound")
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
           if node.name == "sound" {
            print("sound")
           } else if node.name == "music" {
              print("music")
           } else if node.name == "back" {
            self.scene?.view?.presentScene(backScene!, transition: transition)
           }
       }
}
