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
    
    var higthScores: [Int] = []
    var currentScore = 0
    let highScoreKey = "highscores"
    
    override init() {
        super.init()
        loadSettings()
        loadScores()
    }
    
    func saveScores() {
        higthScores.append(currentScore)
        print(currentScore)
        higthScores = Array(higthScores.sorted(by: {$0 > $1} ).prefix(3))
        ud.set(higthScores, forKey: highScoreKey)
        ud.synchronize()
    }
    
    func loadScores() {
        guard ud.value(forKey: highScoreKey) != nil else { return }
        higthScores = ud.value(forKey: highScoreKey) as! [Int]
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
