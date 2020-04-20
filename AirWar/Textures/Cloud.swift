//
//  Cloud.swift
//  AirWar
//
//  Created by Damir Lutfullin on 20.04.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//


import SpriteKit
import GameplayKit

final class Cloud: SKSpriteNode, GameBackgroundSpritable {
    
    static func getSprite(at point: CGPoint?) -> Cloud {
        let cloud = Cloud(imageNamed: "cl" + String(Int.random(in: 1...3)))
        cloud.setScale(CGFloat.random(in: 2...3))
        cloud.position = point ?? randomPoint()
        cloud.zPosition = 10
        cloud.run(move(to: cloud.position))
        cloud.name = "backgroundSprite"
        return cloud
    }
    
    private static func move(to point: CGPoint) -> SKAction {
        let movePoint = CGPoint(x: point.x, y: -200)
        let moveDistance: CGFloat = point.y + 200
        let speed : CGFloat = 150.0
        let duration = moveDistance / speed
        return SKAction.move(to: movePoint, duration: TimeInterval(duration))
    }
}
