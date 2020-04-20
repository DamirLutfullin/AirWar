//
//  GameBackGroundSpritable.swift
//  AirWar
//
//  Created by Damir Lutfullin on 20.04.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import Foundation
import SpriteKit

protocol GameBackgroundSpritable {
    static func getSprite() -> Self
    static func randomPoint() -> CGPoint
}

extension GameBackgroundSpritable {
    static func randomPoint() -> CGPoint {
        let screen = UIScreen.main.bounds
        let randomYPosition = CGFloat.random(in: (screen.size.height + 100) ... (screen.size.height + 200))
        let xPosition = CGFloat.random(in: 0 ... screen.size.width)
        return CGPoint(x: xPosition, y: randomYPosition)
    }
}

