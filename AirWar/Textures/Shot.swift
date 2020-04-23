//
//  Shot.swift
//  AirWar
//
//  Created by Damir Lutfullin on 23.04.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import SpriteKit

class Shot: SKSpriteNode {
    let initialSize = CGSize(width: 187, height: 237)
    let textureAtlas : SKTextureAtlas!
    var animationSpriteArray: [SKTexture] = []
    let screen = UIScreen.main.bounds
    
    init(at point: CGPoint) {
        self.textureAtlas = SKTextureAtlas(named: "YellowAmmo.atlas")
        let textureName = textureAtlas.textureNames.sorted()[0]
        let texture = textureAtlas.textureNamed(textureName)
        super.init(texture: texture, color: .clear, size: initialSize)
        super.name = "spriteShot"
        self.zPosition = 19
        self.setScale(0.3)
        self.position = CGPoint(x: point.x, y: point.y)
    }
    
    func startMovement() {
        performRotation()
        self.run(SKAction.moveTo(y: screen.height + 100, duration: 3))
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
