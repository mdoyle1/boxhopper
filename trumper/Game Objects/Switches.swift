//
//  Barriers.swift
//  trumper
//
//  Created by developer on 8/26/20.
//  Copyright © 2020 administrator. All rights reserved.
//

import Foundation
import SpriteKit

//THE SWITCHES CONTROLL THE SPEED AND DIRECTION OF THE TRAIN

class Switches: SKSpriteNode {
    var barriers:SKSpriteNode = SKSpriteNode()
    var xPosition:CGFloat = CGFloat()
    init(){
        super.init(texture: .none, color: .clear, size: CGSize(width: 100, height:100))
        name = "barriers"
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: size.width, height: size.height), center: CGPoint(x: size.width/2, y: size.height/2))
        anchorPoint = CGPoint(x:0,y:0)
        //position = CGPoint(x: xPosition, y:frame.origin.y)
        physicsBody?.isDynamic = false
        physicsBody?.affectedByGravity = false
        zPosition = 2
        physicsBody?.friction = 0
        physicsBody?.mass = 20
        physicsBody?.contactTestBitMask = PhysicsCategory.trainCar.rawValue | PhysicsCategory.locamotive.rawValue | PhysicsCategory.trump.rawValue
        physicsBody?.categoryBitMask = PhysicsCategory.barriers.rawValue
        physicsBody?.collisionBitMask = PhysicsCategory.trainCar.rawValue | PhysicsCategory.locamotive.rawValue | PhysicsCategory.trump.rawValue
        physicsBody?.usesPreciseCollisionDetection = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
