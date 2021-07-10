//
//  level1.swift
//  trumper
//
//  Created by Doyle, Mark(Information Technology Services) on 1/23/19.
//  Copyright © 2019 administrator. All rights reserved.
//

import Foundation
import SpriteKit

let level = SKSpriteNode(imageNamed: "level1")
let level1Texture = SKTexture(imageNamed: "level1.png")

func startLevel1(){
    level.physicsBody = SKPhysicsBody(texture: level1Texture, size: CGSize(width: level.size.width, height: level.size.height))
    level.physicsBody!.isDynamic = true
    level.physicsBody?.restitution = 0
    level.physicsBody!.affectedByGravity = false
    level.physicsBody!.allowsRotation = false
    level.zPosition = 2
    
    
}
