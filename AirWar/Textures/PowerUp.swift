//
//  powerUp.swift
//  AirWar
//
//  Created by Damir Lutfullin on 22.04.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import SpriteKit
import UIKit

enum TypePowerUp: String {
    case green = "GreenPowerUp.atlas"
    case blue = "BluePowerUp.atlas"
}

class PowerUp: SKSpriteNode {
    
    let initialSize = CGSize(width: 52, height: 52)
    let textureAtlas : SKTextureAtlas!
    var animationSpriteArray: [SKTexture] = []
    
    init(type: TypePowerUp) {
        self.textureAtlas = SKTextureAtlas(named: type.rawValue)
        let textureName = textureAtlas.textureNames.sorted()[0]
        let texture = textureAtlas.textureNamed(textureName)
        super.init(texture: texture, color: .clear, size: initialSize)
        super.name = "powerUp"
        self.zPosition = 20
    }
    
    func startMovament() {
        func performRotation() {
            for texture in textureAtlas.textureNames.sorted() {
                animationSpriteArray.append(SKTexture(imageNamed: texture))
            }
            
            SKTexture.preload(animationSpriteArray) {
                let rotation = SKAction.animate(with: self.animationSpriteArray, timePerFrame: 0.07, resize: true, restore: false)
                let rotationForever = SKAction.repeatForever(rotation)
                self.run(rotationForever)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
