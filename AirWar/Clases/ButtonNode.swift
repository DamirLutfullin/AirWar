//
//  ButtonNode.swift
//  AirWar
//
//  Created by Damir Lutfullin on 25.04.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import SpriteKit

class ButtonNode: SKSpriteNode {
    
    let label: SKLabelNode = {
        let l = SKLabelNode(text: "kek")
        l.fontColor = SKColor(red: 219/255, green: 226/255, blue: 215/255, alpha: 1)
        l.fontName = "AmericanTypewriter-Bold"
        l.fontSize = 30
        l.horizontalAlignmentMode = .center
        l.verticalAlignmentMode = .center
        l.zPosition = 2
        return l
    } ()
    
    init(title: String, backgroundNamed: String) {
        let texture = SKTexture(imageNamed: backgroundNamed)
        super.init(texture: texture, color: .clear, size: texture.size())
        label.text = title.uppercased()
        addChild(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
