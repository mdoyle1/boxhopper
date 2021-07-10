//
//  TrainPlatform.swift
//  trumper
//
//  Created by developer on 8/21/20.
//  Copyright © 2020 administrator. All rights reserved.
//

import Foundation
import SpriteKit

 let platformSpeed: CGFloat = 80.0
//PLATFORM MOVING
func platformMotion(platform:SKSpriteNode, frameWidth:CGFloat){
    
if(platform.position.x <= platform.size.width/2.0 + 20.0 && (platform.physicsBody?.velocity.dx)! < 0.0 ){

    platform.physicsBody?.velocity = CGVector(dx: platformSpeed, dy: 0.0)


} else if(platform.position.x >= frameWidth - platform.size.width/2.0 - 20.0 && (platform.physicsBody?.velocity.dx)! >= 0.0){

    platform.physicsBody?.velocity = CGVector(dx: -platformSpeed, dy: 0.0)

}else if((platform.physicsBody?.velocity.dx)! > 0.0){
    platform.physicsBody?.velocity = CGVector(dx: platformSpeed, dy: 0.0)

     }else{
    platform.physicsBody?.velocity = CGVector(dx: -platformSpeed, dy: 0.0)

     }

}


class TrainPlatform:SKSpriteNode {
 let platform = SKSpriteNode()
    init(){
    super.init(texture: .none, color: .black, size: CGSize(width: 300, height: 10))
    name = "platform"
   physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: size.width, height: size.height), center: CGPoint(x: size.width/2, y: size.height/2))
   zPosition = 2
    anchorPoint = CGPoint(x: 0, y: 0)
    physicsBody?.affectedByGravity = false
    physicsBody?.isDynamic = true
    physicsBody?.friction = 0.5
    physicsBody?.restitution = 0.0
    physicsBody?.mass = 20
    physicsBody?.collisionBitMask = 0
    physicsBody?.categoryBitMask = PhysicsCategory.jumpUnderPlatform.rawValue
    position = CGPoint(x: 0, y: -330)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
