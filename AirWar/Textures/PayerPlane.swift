//
//  PayerPlane.swift
//  AirWar
//
//  Created by Damir Lutfullin on 20.04.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import SpriteKit
import CoreMotion

class PayerPlane: SKSpriteNode {
    
    var moveDirection: TurnDirection = .center
    var stillTurning = false
    
    let motionManager = CMMotionManager()
    var xAcceleration: CGFloat = 0
    let screenSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    let textureAtlas = SKTextureAtlas(named: "PlayerPlane")
    var leftArrayTexture = [SKTexture]()
    var rigthArrayTexture = [SKTexture]()
    var centerArrayTexture = [SKTexture]()

    static func getSprite() -> PayerPlane {
        let playerPlaneTexture = SKTexture(imageNamed: "airplane_3ver2_13")
        let playerPlane = PayerPlane(texture: playerPlaneTexture)
        playerPlane.setScale(0.5)
        playerPlane.position = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: 100)
        playerPlane.zPosition = 20
        return playerPlane
    }
    
    func performFly() {
        planeAnimationFillArray()
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) {
            [unowned self] (data, error) in
            if let data = data {
                let acceleration = data.acceleration
                self.xAcceleration = CGFloat(acceleration.x) * 0.7 + self.xAcceleration * 0.3
            }
        }
        
        let planeWaitAction = SKAction.wait(forDuration: 1.0)
        let directionCheckAction = SKAction.run { [unowned self] in
            self.movementDirectionCheck()
        }
        let planeSequence = SKAction.sequence([planeWaitAction, directionCheckAction])
        self.run(SKAction.repeatForever(planeSequence))
    }
    
    func checkPosition() {
        self.position.x += xAcceleration * 50
        if self.position.x < -70 {
            self.position.x = screenSize.width + 70
        } else if self.position.x > screenSize.width + 70 {
            self.position.x = -70
        }
    }
    
    // модифицировать
    fileprivate func planeAnimationFillArray() {
        SKTextureAtlas.preloadTextureAtlases([textureAtlas]) {
            
            self.leftArrayTexture = {
                var array = [SKTexture]()
                for i in stride(from: 13, through: 1, by: -1) {
                    let number = String(format: "%02d", i)
                     array.append(SKTexture(imageNamed: "airplane_3ver2_" + number))
                }
                SKTexture.preload(array) {
                    print("done")
                }
                return array
            }()
            
            self.rigthArrayTexture = {
                var array = [SKTexture]()
                for i in stride(from: 13, through: 26, by: 1) {
                    let number = String(format: "%02d", i)
                     array.append(SKTexture(imageNamed: "airplane_3ver2_" + number))
                }
                SKTexture.preload(array) {
                    print("done")
                }
                return array
            }()
            
            self.centerArrayTexture = {
                var array = [SKTexture]()
                array.append(SKTexture(imageNamed: "airplane_3ver2_13"))
                SKTexture.preload(array) {
                    print("done")
                }
                return array
            }()
        }
    }
    
    private func movementDirectionCheck() {
        if xAcceleration > 0.1, moveDirection != .right, stillTurning == false {
            stillTurning = true
            moveDirection = .right
            
            
        } else if xAcceleration < 0.1, moveDirection != .letf, stillTurning == false {
            stillTurning = true
            moveDirection = .letf
            
        } else if stillTurning == false {
            
        }
    }
    
    private func turnPlane(direction: TurnDirection) {
        var array = [SKTexture]()
        switch direction {
        case .letf:
            array = leftArrayTexture
        case .center:
            array = centerArrayTexture
        case .right:
            array = rigthArrayTexture
        }
        
        let forwardAction = SKAction.animate(with: array, timePerFrame: 0.5, resize: true, restore: false)
        let backwardAction = SKAction.animate(with: array.reversed(), timePerFrame: 0.5, resize: true, restore: false)
        
        let sequenceAction = SKAction.sequence([forwardAction, backwardAction])
        self.run(sequenceAction) { [unowned self] in
            self.stillTurning = false
        }
    }
}

enum TurnDirection {
    case letf
    case center
    case right
}
