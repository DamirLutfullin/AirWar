//
//  Island.swift
//  AirWar
//
//  Created by Damir Lutfullin on 20.04.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import SpriteKit
import GameplayKit

class Island: SKSpriteNode {
    
    static func getIsland(at point: CGPoint) -> Island {
        let island = Island(imageNamed: "is" + String(Int.random(in: 1...4)))
        island.setScale(CGFloat.random(in: 0.1...1.0))
        island.zRotation = CGFloat.random(in: 0 ... 2 * CGFloat.pi)
        island.position = point
        island.zPosition = 1
        return island
        
    }
}
