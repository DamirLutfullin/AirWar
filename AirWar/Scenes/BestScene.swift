//
//  BestScene.swift
//  AirWar
//
//  Created by Damir Lutfullin on 26.04.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import SpriteKit

class BestScene: ParentScene {
    
    var scores: [Int]!
    
    override func didMove(to view: SKView) {
        gameSettings.loadScores()
        
        scores = gameSettings.higthScores
        
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
        
        
        for (index, value) in scores.enumerated() {
            let label = SKLabelNode()
            label.text = value.description
            label.fontColor = SKColor(red: 219/255, green: 226/255, blue: 215/255, alpha: 1)
            label.fontName = "AmericanTypewriter-Bold"
            label.fontSize = 30
            label.zPosition = 2
            label.position = CGPoint(x: self.frame.midX, y: self.frame.minY + 450 + backButton.frame.height + CGFloat((scores.count - index) * 50) )
            addChild(label)
        }
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
