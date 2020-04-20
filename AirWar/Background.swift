//
//  Background.swift
//  AirWar
//
//  Created by Damir Lutfullin on 20.04.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import UIKit
import GameKit

class Background: SKSpriteNode {
    static func background(at point: CGPoint) -> Background {
        let background = Background(imageNamed: "background")
        background.anchorPoint = .zero
        background.position = point
        background.zPosition = 0
        return background
    }
}
