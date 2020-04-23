//
//  Assets.swift
//  AirWar
//
//  Created by Damir Lutfullin on 24.04.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import SpriteKit

class Assets {
    static var shared = Assets()
    let playerAtlas = SKTextureAtlas(named: "PlayerPlane")
    let yellowShotAtlas = SKTextureAtlas(named: "YellowAmmo")
    let greenPowerUpAtlas = SKTextureAtlas(named: "GreenPowerUp")
    let bluePowerUpAtlas = SKTextureAtlas(named: "BluePowerUp")
    let enemy_1Atlas = SKTextureAtlas(named: "Enemy_1")
    let enemy_2Atlas = SKTextureAtlas(named: "Enemy_2")
    
    func preloadAssests() {
        playerAtlas.preload { print("playerAtlas preloaded") }
        yellowShotAtlas.preload { print("yellowShotAtlas preloaded") }
        greenPowerUpAtlas.preload { print("greenPowerUpAtlas preloaded") }
        bluePowerUpAtlas.preload { print("bluePowerUpAtlas preloaded") }
        enemy_1Atlas.preload { print("enemy_1Atlas preloaded") }
        enemy_2Atlas.preload { print("enemy_2Atlas preloaded") }
    }
}
