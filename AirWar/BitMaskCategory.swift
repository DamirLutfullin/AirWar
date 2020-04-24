//
//  BitMaskCategory.swift
//  AirWar
//
//  Created by Damir Lutfullin on 24.04.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import Foundation
import SpriteKit


struct BitMaskCategory: OptionSet {
    let rawValue : UInt32
    
    static let none    = BitMaskCategory(rawValue: 0 << 0)
    static let player  = BitMaskCategory(rawValue: 1 << 0)
    static let enemy   = BitMaskCategory(rawValue: 1 << 1)
    static let powerUp = BitMaskCategory(rawValue: 1 << 2)
    static let shot    = BitMaskCategory(rawValue: 1 << 3)
    static let all     = BitMaskCategory(rawValue: UInt32.max)
}

extension SKPhysicsBody {
    var category: BitMaskCategory {
        get {
            return BitMaskCategory(rawValue: self.categoryBitMask)
        }
        set {
            self.categoryBitMask = newValue.rawValue
        }
    }
}
