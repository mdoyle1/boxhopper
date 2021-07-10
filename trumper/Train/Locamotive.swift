//
//  Locamotive.swift
//  trumper
//
//  Created by developer on 8/21/20.
//  Copyright © 2020 administrator. All rights reserved.
//

import Foundation
import SpriteKit


class Locamotive: SKSpriteNode {
    init(){
        super.init(texture: .none, color: .red, size: CGSize(width: 1600, height:700))
        name = "locamotive"
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: size.width, height: size.height), center: CGPoint(x: size.width/2, y: size.height/2))
        position = CGPoint(x: 3000, y:0)
        physicsBody?.allowsRotation = false
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = true
        physicsBody?.categoryBitMask = PhysicsCategory.locamotive.rawValue
        physicsBody?.contactTestBitMask = PhysicsCategory.trump.rawValue | PhysicsCategory.solidSurface.rawValue | PhysicsCategory.trainCar.rawValue | PhysicsCategory.barriers.rawValue
        physicsBody?.collisionBitMask = PhysicsCategory.trainCar.rawValue | PhysicsCategory.locamotive.rawValue | PhysicsCategory.barriers.rawValue
        physicsBody?.usesPreciseCollisionDetection = true
        anchorPoint = CGPoint(x: 0, y: 0)
        zPosition = Layer.train
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
