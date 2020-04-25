//
//  Enemy.swift
//  AirWar
//
//  Created by Damir Lutfullin on 23.04.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import SpriteKit

class Enemy: SKSpriteNode {
    
    static var textureAtlas: SKTextureAtlas?
    var enemyTexture: SKTexture!
    
    init(enemyTexture: SKTexture) {
        let texture = enemyTexture
        super.init(texture: texture, color: .clear, size: CGSize(width: 221, height: 204))
        self.xScale = 0.5
        self.yScale = -0.5
        self.zPosition = 20
        self.name = "sprite"

        
        let offsetX = self.frame.size.width * self.anchorPoint.x
        let offsetY = self.frame.size.height * self.anchorPoint.y
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 8 - offsetX, y: 69 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 50 - offsetX, y: 97 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 61 - offsetX, y: 97 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 106 - offsetX, y: 69 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 65 - offsetX, y: 47 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 74 - offsetX, y: 6 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 38 - offsetX, y: 4 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 46 - offsetX, y: 45 - offsetY), transform: .identity)
        path.closeSubpath()
        
        
        self.physicsBody = SKPhysicsBody(polygonFrom: path)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = BitMaskCategory.enemy.rawValue
        self.physicsBody?.collisionBitMask = BitMaskCategory.shot.rawValue | BitMaskCategory.player.rawValue
        self.physicsBody?.contactTestBitMask = BitMaskCategory.shot.rawValue | BitMaskCategory.player.rawValue
    }
    
    func flySpiral() {
        let screenSize = UIScreen.main.bounds
        let timeHorizontal: Double = 3
        let timeVertical: Double = 5
        let moveLeft = SKAction.moveTo(x: 50, duration: timeHorizontal)
        moveLeft.timingMode = .easeInEaseOut
        let moveRight = SKAction.moveTo(x: screenSize.width - 50, duration: timeHorizontal)
        moveRight.timingMode = .easeInEaseOut
        
        let randomInt = Int.random(in: 0...1)
        let asideMovementSequence = randomInt == 0 ? SKAction.sequence([moveLeft, moveRight]) : SKAction.sequence([moveRight, moveLeft])
        let foreverAsideMovement = SKAction.repeatForever(asideMovementSequence)
        
        let forwardMovement = SKAction.moveTo(y: -300, duration: timeVertical)
        let groupMovement = SKAction.group([foreverAsideMovement, forwardMovement])
        self.run(groupMovement)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
