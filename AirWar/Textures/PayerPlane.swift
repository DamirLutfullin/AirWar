//
//  PayerPlane.swift
//  AirWar
//
//  Created by Damir Lutfullin on 20.04.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import SpriteKit

class PayerPlane: SKSpriteNode {
    static func getPlain(at point: CGPoint) -> SKSpriteNode {
        let planeTexture = SKTexture(imageNamed: "airplane_3ver2_13")
        let plane = SKSpriteNode(texture: planeTexture)
        plane.setScale(0.5)
        plane.position = point
        plane.zPosition = 20
        return plane
    }
}
