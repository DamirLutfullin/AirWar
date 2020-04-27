//
//  GameSettings.swift
//  AirWar
//
//  Created by Damir Lutfullin on 28.04.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import UIKit

class GameSettings: NSObject {
    
    let ud = UserDefaults.standard
    
    var isMusic = true
    var isSounds = true
    
    let musicKey = "music"
    let soundKey = "sound"
    
    override init() {
        super.init()
        loadSettings()
    }
    
    func saveSettings() {
        ud.set(isMusic, forKey: musicKey)
        ud.set(isSounds, forKey: soundKey)
    }
    
    func loadSettings() {
        if ud.value(forKey: musicKey) != nil && ud.value(forKey: soundKey) != nil {
        isMusic = ud.bool(forKey: musicKey)
        isSounds = ud.bool(forKey: soundKey)
        }
    }
    
}
