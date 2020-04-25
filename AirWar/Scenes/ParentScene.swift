//
//  ParentScene.swift
//  AirWar
//
//  Created by Damir Lutfullin on 26.04.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import SpriteKit

class ParentScene: SKScene {
    var backScene : SKScene?
   
    func setHeader(name: String?, background: String) {
        let header = ButtonNode(title: name ?? "", backgroundNamed: background)
        header.position = CGPoint(x: self.frame.midX,y: self.frame.height - 150)
        header.zPosition = 1
        self.addChild(header)
    }
}
