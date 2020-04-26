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
    
    let type: TypePowerUp
    let initialSize = CGSize(width: 52, height: 52)
    let textureAtlas : SKTextureAtlas!
    var animationSpriteArray: [SKTexture] = []
    
    init(type: TypePowerUp) {
        self.textureAtlas = type == .blue ?  Assets.shared.bluePowerUpAtlas : Assets.shared.greenPowerUpAtlas
        let textureName = textureAtlas.textureNames.sorted()[0]
        let texture = textureAtlas.textureNamed(textureName)
        self.type = type
        super.init(texture: texture, color: .clear, size: initialSize)
        super.name = "sprite"
        self.zPosition = 20
        
        let offsetX = self.frame.size.width * self.anchorPoint.x
        let offsetY = self.frame.size.height * self.anchorPoint.y

        let path = CGMutablePath()
        path.move(to: CGPoint(x: 11 - offsetX, y: 30 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 22 - offsetX, y: 30 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 23 - offsetX, y: 8 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 10 - offsetX, y: 7 - offsetY), transform: .identity)
        path.closeSubpath()

        self.physicsBody = SKPhysicsBody(polygonFrom: path)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = BitMaskCategory.powerUp.rawValue
        self.physicsBody?.collisionBitMask = BitMaskCategory.none.rawValue
        self.physicsBody?.contactTestBitMask = BitMaskCategory.player.rawValue
        
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
