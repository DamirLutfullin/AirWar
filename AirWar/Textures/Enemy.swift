//
//  Enemy.swift
//  AirWar
//
//  Created by Damir Lutfullin on 23.04.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import SpriteKit

class Enemy: SKSpriteNode {
    
    init() {
        let enemy = SKTexture(imageNamed: "airplane_4ver2_13")
        super.init(texture: enemy, color: .clear, size: CGSize(width: 221, height: 204))
        self.xScale = 0.5
        self.yScale = -0.5
        self.zPosition = 20
        self.name = "enemy"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
