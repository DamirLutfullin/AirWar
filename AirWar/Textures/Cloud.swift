//
//  Cloud.swift
//  AirWar
//
//  Created by Damir Lutfullin on 20.04.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//


import SpriteKit
import GameplayKit

class Cloud: SKSpriteNode {
    
    static func getCloud(at point: CGPoint) -> Cloud {
        let cloud = Cloud(imageNamed: "cl" + String(Int.random(in: 1...3)))
        cloud.setScale(CGFloat.random(in: 2...3))
        cloud.position = point
        cloud.zPosition = 10
        cloud.run(move(to: point))
        return cloud
    }
    
    private static func move(to point: CGPoint) -> SKAction {
        let movePoint = CGPoint(x: point.x, y: point.y - 400)
        let moveDistance: CGFloat = point.y + 400
        let speed : CGFloat = 20.0
        let duration = moveDistance / speed
        return SKAction.move(to: movePoint, duration: TimeInterval(duration))
       }
}
