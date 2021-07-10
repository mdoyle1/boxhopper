//
//  spriteActions.swift
//  trumper
//
//  Created by administrator on 1/21/19.
//  Copyright © 2019 administrator. All rights reserved.
//

import Foundation
import SpriteKit

var gamescene : GameScene!
var walkAnimation: SKAction?
var isRight : Bool?
var isLeft : Bool?
let moveLeft = SKSpriteNode(color:SKColor.red,size:CGSize(width: 20, height:20))
let moveRight = SKSpriteNode(color:SKColor.orange,size:CGSize(width: 20, height:20))
let jumper = SKSpriteNode(color:SKColor.green,size:CGSize(width: 20, height:20))
var jumpWasPressed:Bool = false
//var inTheAir:Bool = false

//Move Actions
func walk(image: String, sprite: SKSpriteNode) {
    //create an array of textures by looping trough the images...
    var walkTexture: [SKTexture] = []
    //var walkPhysicsBody: [SKTexture] = []
    for i in 1...4 {
        walkTexture.append(SKTexture(imageNamed: "\(image)\(i)"))
    }
    walkTexture.append(walkTexture[2])
    walkTexture.append(walkTexture[1])
    walkAnimation = SKAction.animate(with: walkTexture, timePerFrame: 0.1)
    
    sprite.run(SKAction.repeatForever(walkAnimation!), withKey: "walk")
}



func moveBy(sprite: SKSpriteNode, imageName: String, rightLeft: CGFloat, forTheKey: String){
    sprite.xScale=rightLeft
    walk(image:imageName, sprite:sprite)
    isLeft = false
    isRight = true
    
}

func jump(sprite: SKSpriteNode, imageName: String, platform:SKSpriteNode){

platform.physicsBody?.collisionBitMask = 0
platform.physicsBody?.categoryBitMask = PhysicsCategory.jumpUnderPlatform.rawValue
  
      print("In The Air")
    if jumpWasPressed == false {
        jumpWasPressed = true
              playerA.physicsBody?.velocity.dy += CGFloat(800)
        }
//
//    else {
//    playerA.physicsBody?.velocity.dy += CGFloat(800)
//    }
}


func touchLogic(touches:Set<UITouch>, self: GameScene,xPos: CGFloat, platform: SKSpriteNode){
for touch in touches {
    let location = touch.location(in: self);

    if(location.x < xPos){
        isLeft = true
        isRight = false
        playerA.xVelocity = -800
        print("Left")

          moveBy(sprite: playerA, imageName: "trump", rightLeft: -1, forTheKey: "left")
            playerA.removeAction(forKey: "right")
     
        }
    
    if(location.x > xPos){
        isRight = true
        isLeft = false
        playerA.xVelocity = 800
        print("Right")
        moveBy(sprite: playerA, imageName: "trump", rightLeft: 1, forTheKey: "right")
    
        playerA.physicsBody?.applyForce(CGVector(dx: 100, dy: 0))
        playerA.removeAction(forKey: "left")
  
    }
    
    if(location.y > playerA.position.y && playerA.action(forKey: "jump") == nil){
        print(playerA.position)
        print(playerA.physicsBody?.velocity.dy)
        
        jump(sprite: playerA, imageName: "trump", platform: platform)
        
    }
    }
    //
    if (isRight == true && isLeft == true){
        print("Both touched")
        isRight = false
        isLeft = false
    }

}






    


func playerPhysicalMovement (player: PlayerA){
    let rate: CGFloat = 0.02; //Controls rate of motion. 1.0 instantaneous, 0.0 none.
    let relativeVelocity: CGVector = CGVector(dx:player.xVelocity-(player.physicsBody?.velocity.dx)!, dy:player.yVelocity-(player.physicsBody?.velocity.dy)!);
    
    player.physicsBody!.velocity=CGVector(dx:(player.physicsBody?.velocity.dx)!+relativeVelocity.dx*rate, dy:(player.physicsBody?.velocity.dy)!+relativeVelocity.dy*rate)
}
