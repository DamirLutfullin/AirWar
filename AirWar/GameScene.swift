//
//  GameScene.swift
//  AirWar
//
//  Created by Damir Lutfullin on 18.04.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var player: PlayerPlane!
    var shot: Shot!
    
    override func didMove(to view: SKView) {
        configureStartScene()
        backGroundGenerate(object: Cloud.self, pause: 3)
        backGroundGenerate(object: Island.self, pause: 2)
        player.performFly()
        
        spawnPowerUp()
        spawnEminies(pause: 3)
    }
    
    fileprivate func spawnPowerUp() {
        let pause = SKAction.wait(forDuration: TimeInterval.random(in: 5.0 ... 10.0))
        let addPowerUp = SKAction.run {
            let powerUp = PowerUp(type: TypePowerUp.allCases.randomElement()!)
            self.addChild(powerUp)
        }
        let sequence = SKAction.sequence([addPowerUp, pause])
        run(SKAction.repeatForever(sequence))
    }
    
    private func spawnEminies(pause: Double) {
        let pause = SKAction.wait(forDuration: pause)
        let spawnSpiralAction = SKAction.run { [unowned self] in
            self.spawnSpiralEnemies()
        }
        
        let sequence = SKAction.sequence([spawnSpiralAction, pause])
        run(SKAction.repeatForever(sequence))
    }
    
    fileprivate func spawnSpiralEnemies() {
        let enemyTextureAtlas1 = SKTextureAtlas(named: "Enemy_1")
        let enemyTextureAtlas2 = SKTextureAtlas(named: "Enemy_2")
        SKTextureAtlas.preloadTextureAtlases([enemyTextureAtlas1, enemyTextureAtlas2]) { [unowned self] in
            let randomNumber = Int.random(in: 0...1)
            let arrayOfAtases = [enemyTextureAtlas1, enemyTextureAtlas2]
            let textureAtlas = arrayOfAtases[randomNumber]
            let waitAction = SKAction.wait(forDuration: 1.0)
           
            let spawnEnemy = SKAction.run({ [unowned self] in
                let texture = textureAtlas.textureNames.sorted()[13]
                let enemy = Enemy(enemyTexture: SKTexture(imageNamed: texture))
                enemy.position = CGPoint(x: self.size.width / 2, y: self.size.height + 110)
                self.addChild(enemy)
                enemy.flySpiral()
            })
            
            let spawnAction = SKAction.sequence([waitAction, spawnEnemy])
            let repeatAction = SKAction.repeat(spawnAction, count: 3)
            self.run(repeatAction)
        }
    }
    
    func configureStartScene() {
        let background = Background.background(at: self.anchorPoint)
        background.size = self.size
        self.addChild(background)
        player = PlayerPlane.populate(at: CGPoint(x: self.size.width / 2, y: 100))
        self.addChild(player)
    }
    
    func backGroundGenerate(object: GameBackgroundSpritable.Type, pause: Int) {
        
        let pause = SKAction.wait(forDuration: TimeInterval(pause))
        let spawnObjects = SKAction.run {
            if object is Cloud.Type {
                let cloud = object as! Cloud.Type
                self.addChild(cloud.getSprite(at: nil))
            } else if object is Island.Type {
                let island = object as! Island.Type
                self.addChild(island.getSprite(at: nil))
            }
        }
        
        let spawnSequence = SKAction.sequence([pause, spawnObjects])
        let spawnSequenceForever = SKAction.repeatForever(spawnSequence)
        run(spawnSequenceForever)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        playerFire()
    }
    
    override func didSimulatePhysics() {
        super.didSimulatePhysics()
        player.checkPosition()
        
        enumerateChildNodes(withName: "sprite") { (node, _) in
            if node.position.y < -190 {
                node.removeFromParent()
            }
        }
        
        enumerateChildNodes(withName: "spriteShot") { (node, _) in
            if node.position.y >= self.size.height + 100 {
                node.removeFromParent()
            }
        }
    }
    
    private func playerFire() {
        let shot = Shot(at: player.position)
        shot.startMovement()
        self.addChild(shot)
    }
}
