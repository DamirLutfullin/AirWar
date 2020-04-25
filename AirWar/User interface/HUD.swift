//
//  HUD.swift
//  AirWar
//
//  Created by Damir Lutfullin on 25.04.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import SpriteKit

class HUD: SKScene {
    
    static var shared = HUD()
    
    let life1 = SKSpriteNode(imageNamed: "life")
    let life2 = SKSpriteNode(imageNamed: "life")
    let life3 = SKSpriteNode(imageNamed: "life")
    
    let menuButton = SKSpriteNode(imageNamed: "menu")
    let scoreBackground = SKSpriteNode(imageNamed: "scores")
    let scoresLabel = SKLabelNode(text: "1000")
    
    func configureUI(screenSize : CGSize) {
           scoreBackground.anchorPoint = CGPoint(x: 0, y: 1)
           scoreBackground.position = CGPoint(x: 15, y: screenSize.height - 40)
           scoreBackground.zPosition = 99
           addChild(scoreBackground)
           
           scoresLabel.verticalAlignmentMode = .center
           scoresLabel.horizontalAlignmentMode = .right
           scoresLabel.zPosition = 100
           scoresLabel.fontName = "AmericanTypewriter-Bold"
           scoresLabel.fontSize = 30
           scoresLabel.position = CGPoint(x: scoreBackground.size.width - 10, y: -scoreBackground.size.height / 2 + 3)
           scoreBackground.addChild(scoresLabel)
           
           menuButton.anchorPoint = CGPoint(x: 0, y: 0)
           menuButton.position = CGPoint(x: 20, y: 30)
           menuButton.zPosition = 100
           addChild(menuButton)
           
           let lifes = [life1, life2, life3]
           
           for (index, life) in lifes.enumerated() {
               life.anchorPoint = CGPoint(x: 0, y: 0)
               life.zPosition = 100
               life.position = CGPoint(
                   x: screenSize.width - (20 + CGFloat((index + 1)) * life.size.width) ,
                   y: scoreBackground.frame.midY - 15
               )
               addChild(life)
           }
           
       }
       
}
