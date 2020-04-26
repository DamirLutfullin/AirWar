//
//  GameScene.swift
//  AirWar
//
//  Created by Damir Lutfullin on 18.04.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: ParentScene {

    var player: PlayerPlane!
    var shot: Shot!
    let hud = HUD()

    override func didMove(to view: SKView) {
        self.scene?.isPaused = false
        // checking if scene persists
        guard SceneManager.shared.scene == nil else { return } // если наша сцена не существует, то мы создаем ее в этом методе, иначе выходим из этого метода
        
        SceneManager.shared.scene = self
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = .zero
        
        configureStartScene()
        backGroundGenerate(object: Cloud.self, pause: 3)
        backGroundGenerate(object: Island.self, pause: 2)
        
        player.performFly()
        spawnPowerUp()
        spawnEminies(pause: 3)
        addChild(hud)
        hud.configureUI(screenSize: self.size)
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
        let enemyTextureAtlas1 = Assets.shared.enemy_1Atlas
        let enemyTextureAtlas2 = Assets.shared.enemy_2Atlas
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
        let location = touches.first?.location(in: self)
        let node = self.atPoint(location!)
        if node.name == "menu" {
            self.scene?.isPaused = true
            SceneManager.shared.scene = self
            let transition = SKTransition.fade(withDuration: 1)
            let menuScene = PauseScene(size: self.size)
            menuScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(menuScene, transition: transition)
        } else {
            playerFire()
        }
    }

    override func didSimulatePhysics() {
        player.checkPosition()
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        enumerateChildNodes(withName: "sprite") { (node, stop) in
            if node.position.y <= -200 {
                node.removeFromParent()
            }
        }
        enumerateChildNodes(withName: "shotSprite") { (node, stop) in
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

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let contactCategory: BitMaskCategory = [contact.bodyA.category, contact.bodyB.category]
        let explosion = SKEmitterNode(fileNamed: "EnemyExplosion.sks")
        explosion?.zPosition = 25
        explosion?.position = contact.contactPoint
        let waitForExplosion = SKAction.wait(forDuration: 1)
        
        switch contactCategory {
        case [.player, .enemy]:
            if contact.bodyA.node?.name == "sprite" {
                contact.bodyA.node?.removeFromParent()
            } else {
                contact.bodyB.node?.removeFromParent()
            }
            addChild(explosion!)
            self.run(waitForExplosion) {
                explosion?.removeFromParent()
            }
        case [.powerUp, .player]:
            print("powerUp vs player")
        case [.shot, .enemy]:
            contact.bodyA.node?.removeFromParent()
            contact.bodyB.node?.removeFromParent()
            addChild(explosion!)
            self.run(waitForExplosion) {
                explosion?.removeFromParent()
            }
        default:
            preconditionFailure("error")
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        
    }
}
