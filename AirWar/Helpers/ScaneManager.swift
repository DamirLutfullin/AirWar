//
//  ScaneManager.swift
//  AirWar
//
//  Created by Damir Lutfullin on 25.04.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import SpriteKit

class SceneManager {
    static var shared = SceneManager()
    var scene: GameScene?
    var backScene: SKScene?
}
