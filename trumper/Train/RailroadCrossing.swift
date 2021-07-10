//
//  RailroadCrossing.swift
//  trumper
//
//  Created by developer on 8/29/20.
//  Copyright © 2020 administrator. All rights reserved.
//

import Foundation
import SpriteKit

class RailroadCrossing: SKSpriteNode {
    
    init(){
          super.init(texture: SKTexture(imageNamed: "railroadcrossing"), color: .clear, size: CGSize(width:200 , height:500))
        name = "railroadcrossingright"
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: size.width, height: size.height), center: CGPoint(x: size.width/2, y: size.height/2))
        position = CGPoint(x: 2900, y:-400)
        physicsBody?.allowsRotation = false
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
        physicsBody?.categoryBitMask = 0
        physicsBody?.contactTestBitMask = PhysicsCategory.trump.rawValue | PhysicsCategory.solidSurface.rawValue | PhysicsCategory.trainCar.rawValue | PhysicsCategory.barriers.rawValue
        physicsBody?.collisionBitMask = 0
        physicsBody?.usesPreciseCollisionDetection = true
        anchorPoint = CGPoint(x: 0, y: 0)
        zPosition = Layer.foreground
}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

