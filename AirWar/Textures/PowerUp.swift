//
//  powerUp.swift
//  AirWar
//
//  Created by Damir Lutfullin on 22.04.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import SpriteKit
import UIKit

enum TypePowerUp: String, CaseIterable {
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
        super.name = "sprite"
        self.zPosition = 20
        self.startMovement()
    }
    
    func startMovement() {
        performRotation()
        let screen = UIScreen.main.bounds
        let randomYPosition = CGFloat.random(in: (screen.size.height + 100) ... (screen.size.height + 200))
        let xPosition = CGFloat.random(in: 20 ... screen.size.width - 20)
        
        self.position = CGPoint(x: xPosition, y: randomYPosition)
        self.run(SKAction.moveTo(y: -210, duration: 10))

    }
    
   private func performRotation() {
        for texture in textureAtlas.textureNames.sorted() {
            animationSpriteArray.append(SKTexture(imageNamed: texture))
        }
        
        SKTexture.preload(animationSpriteArray) {
            let rotation = SKAction.animate(with: self.animationSpriteArray, timePerFrame: 0.07, resize: true, restore: false)
            let rotationForever = SKAction.repeatForever(rotation)
            self.run(rotationForever)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
