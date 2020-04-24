//
//  BitMaskCategory.swift
//  AirWar
//
//  Created by Damir Lutfullin on 24.04.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import Foundation


class BitMaskCategory {
    static let player: UInt32 = 0x1 << 0
    static let enemy: UInt32 = 0x1 << 1
    static let powerUp: UInt32 = 0x1 << 2
    static let shot: UInt32 = 0x1 << 3
}
