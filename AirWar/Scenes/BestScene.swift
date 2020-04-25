//
//  BestScene.swift
//  AirWar
//
//  Created by Damir Lutfullin on 26.04.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import SpriteKit

class BestScene: ParentScene {
    
    override func didMove(to view: SKView) {
        
        let background = Background(imageNamed: "camouflage")
        background.zPosition = 0
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.setScale(1.5)
        
        self.addChild(background)

        setHeader(name: "results", background: "header_background")
        
        
        let backButton = ButtonNode(title: "back", backgroundNamed: "button_background")
        backButton.position = CGPoint(x: self.frame.midX,y: self.frame.minY + 150)
        backButton.zPosition = 1
        backButton.name = "back"
        backButton.label.name = "back"
        addChild(backButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first?.location(in: self)
        let node = self.atPoint(location!)
        let transition = SKTransition.crossFade(withDuration: 1)
        if node.name == "back" {
            self.scene?.view?.presentScene(backScene!, transition: transition)
        }
    }
}
