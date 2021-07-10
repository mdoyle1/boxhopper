//
//  PlayerA.swift
//  trumper
//
//  Created by developer on 8/21/20.
//  Copyright © 2020 administrator. All rights reserved.
//

import Foundation
import SpriteKit

class PlayerA:SKSpriteNode {
    let playerA:SKSpriteNode =  SKSpriteNode(imageNamed: "trump1")
    var xPosition = CGPoint()
    var yPosition = CGPoint()
    var xVelocity: CGFloat = 0
    var yVelocity:CGFloat = 0
    init(){
        let texture = SKTexture(imageNamed: "trump1.pdf")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        name = "trumper"
        
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: size.width-200, height: size.height-30), center: CGPoint(x: -20, y: 0))
        physicsBody!.isDynamic = true
       
        physicsBody?.restitution = 0
        physicsBody?.usesPreciseCollisionDetection = true
        physicsBody!.categoryBitMask = PhysicsCategory.trump.rawValue
        physicsBody?.contactTestBitMask = PhysicsCategory.eyeOfProvidence.rawValue | PhysicsCategory.solidSurface.rawValue | PhysicsCategory.jumpUnderPlatform.rawValue | PhysicsCategory.solidPlatform.rawValue | PhysicsCategory.barriers.rawValue
        physicsBody?.collisionBitMask = PhysicsCategory.solidSurface.rawValue | PhysicsCategory.solidPlatform.rawValue | PhysicsCategory.barriers.rawValue
        physicsBody!.affectedByGravity = true
        physicsBody!.allowsRotation = false
        position = CGPoint(x:1000, y:500)
       
        zPosition = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


}
