//
//  gameObjects.swift
//  trumper
//
//  Created by administrator on 2/2/19.
//  Copyright © 2019 administrator. All rights reserved.
//

//https://stackoverflow.com/questions/48889426/how-to-make-a-delay-in-a-loop-in-spritekit
//https://stackoverflow.com/questions/31652555/how-create-a-flip-effect-for-skspritenode-in-swift

import Foundation
import SpriteKit


//MARK: - COIN
var coin =  SKSpriteNode(imageNamed: "Gold_1.png")
var coinAnimation: SKAction?


func coinSpin(image: String, sprite: SKSpriteNode) {
    //create an array of textures by looping trough the images...
    var coinTexture: [SKTexture] = []
    //var walkPhysicsBody: [SKTexture] = []
    for i in 1...10 {
        coinTexture.append(SKTexture(imageNamed: "\(image)\(i)"))
    }
//    coinTexture.append(coinTexture[2])
//    coinTexture.append(coinTexture[1])
    coinAnimation = SKAction.animate(with: coinTexture, timePerFrame: 0.05)
    
    sprite.run(SKAction.repeatForever(coinAnimation!), withKey: "coinSpin")
}

func deployCoin(position: CGPoint, size: CGSize){
    coin.size = size
    coin.position = position
    coin.zPosition=4
    coinSpin(image: "Gold_", sprite: coin)

}


//MARK: - EFFORTS

//Deply @x:840  Run efforts animation when trump reaches x:800

//var effortsAnimation: SKAction
//var effortsBlobAnimation: SKAction
func flipSprite(spriteToFlip: SKSpriteNode) {
    spriteToFlip.xScale = spriteToFlip.xScale * -1
}



//THIS IS THE BUCKET.  A HAND COMES OUT AND TURNS INTO A TURD LOOKING PYRIMID, OR THE EYE OF PROVIDENCE.
func eyeOfProvidence(image: String, position: CGPoint, size: CGSize) -> SKSpriteNode {

    let efforts =  SKSpriteNode(imageNamed: "efforts1.png")

    _ = SKTexture(imageNamed: "efforts1.pdf")
    //STORE ANIMATION SLIDES IN THESE ARRAYS
    var effortsTextures: [SKTexture] = []
    var effortsBlob: [SKTexture] = []
    
    
    //DEPLOY FIRST PART OF ANIMATION
    for i in 1...17 {
        effortsTextures.append(SKTexture(imageNamed: "\(image)\(i)"))
    }
    //DEPLOY SECOND PART OF ANIMATION
    for i in 14...17 {
        effortsBlob.append(SKTexture(imageNamed: "\(image)\(i)"))
    }
    //FLIP SPIRTE ON X AXIS
    let flip = SKAction.scaleX(to: -1, duration: 0.05)
    let flipPositive = SKAction.scaleX(to: 1, duration: 0.05)
    //CHARACTER ANIMATIONS
    let effortsAnimation = SKAction.animate(with: effortsTextures, timePerFrame: 0.15)
    let effortsBlobAnimation = SKAction.animate(with: effortsBlob, timePerFrame: 0.15)
    //ANIMATION ACTIONS
    let blobLoop = SKAction.repeat(effortsBlobAnimation, count: 3)
    let moveRight = SKAction.moveBy(x:400, y:0, duration: blobLoop.duration)
    let moveLeft = SKAction.moveBy(x: -400, y: 0, duration: blobLoop.duration)
    let right = SKAction.group([blobLoop, moveRight])
    let left = SKAction.group([blobLoop, moveLeft])
    let flipBlobLeft = SKAction.group([flip, left])
    let flipBlobRight = SKAction.group([flipPositive, right])
    let fiveSeconds = SKAction.wait(forDuration: 5)
    let sequence = SKAction.sequence([fiveSeconds, effortsAnimation, flipBlobLeft, flipBlobRight, flipBlobLeft, flipBlobRight, effortsAnimation.reversed()])
    //MAIN ANIMATION
    let animation = SKAction.repeatForever(sequence)
    //RUN IT...
    efforts.run(animation)
    efforts.name = "eyeOfProvidence"
    efforts.size = size
    efforts.physicsBody = SKPhysicsBody(texture: effortsTextures[0], size: CGSize(width: efforts.size.width, height: efforts.size.height))
    efforts.physicsBody?.allowsRotation = false
    efforts.physicsBody!.categoryBitMask = PhysicsCategory.eyeOfProvidence.rawValue
    efforts.physicsBody!.contactTestBitMask = PhysicsCategory.trump.rawValue | PhysicsCategory.solidSurface.rawValue
    efforts.physicsBody?.collisionBitMask = PhysicsCategory.trump.rawValue | PhysicsCategory.solidSurface.rawValue
    efforts.physicsBody?.usesPreciseCollisionDetection = true
    efforts.position = position
    efforts.zPosition=4
   
    
    return efforts
}


