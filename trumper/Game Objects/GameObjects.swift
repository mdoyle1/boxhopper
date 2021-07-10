//
//  GameObjects.swift
//  trumper
//
//  Created by developer on 5/8/20.
//  Copyright © 2020 administrator. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit


// MARK: - Platforms
var zero:UInt32 = 0

func createPlatform(width: Int, height: Int, position: CGPoint) -> SKSpriteNode {
    let platform = SKSpriteNode(color:SKColor.green,size:CGSize(width: width, height:height))
    platform.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: platform.size.width, height: platform.size.height), center: CGPoint(x: platform.size.width/2, y: platform.size.height/2))
  
    platform.physicsBody?.isDynamic = false

    platform.physicsBody?.restitution = 0
    platform.physicsBody?.categoryBitMask = PhysicsCategory.solidSurface.rawValue

    platform.zPosition = 5
    platform.anchorPoint = CGPoint(x:0,y:0)
    platform.position = position
   // addChild(platform)
    return platform
}

func createFloor(frame:CGRect) -> SKSpriteNode {
    let floor = SKSpriteNode(color:.clear,size:CGSize(width: background.size.width*100, height:1))
    floor.position.x = -12000
    floor.position.y = 0
    floor.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: floor.size.width, height: floor.size.height), center: CGPoint(x: floor.size.width/2, y: floor.size.height/2))
    floor.name = "floor"
    floor.physicsBody?.isDynamic = false
    floor.physicsBody?.restitution = 0
    floor.physicsBody?.categoryBitMask = PhysicsCategory.solidSurface.rawValue
    floor.physicsBody?.collisionBitMask = PhysicsCategory.trump.rawValue | PhysicsCategory.eyeOfProvidence.rawValue | PhysicsCategory.locamotive.rawValue | PhysicsCategory.trainCar.rawValue
    floor.zPosition = 4
    floor.anchorPoint = CGPoint(x:0,y:0)
    //floor.position = frame.origin
    return floor
   // addChild(floor)

}


//MARK: - SHAPES

func oneLittleCircle() -> SKShapeNode {
     let Circle = SKShapeNode(circleOfRadius: 100 ) // Create circle
     Circle.zPosition = 4
     Circle.position = CGPoint(x: 0, y: 0)  // Center (given scene anchor point is 0.5 for x&y)
     Circle.strokeColor = SKColor.black
     Circle.glowWidth = 1.0
     Circle.fillColor = SKColor.orange
     //self.addChild(Circle)
     return Circle
 }

//MARK: - BRICKS
func createBrick(width: Int, height: Int, color: SKColor, Placement: CGPoint) -> SKSpriteNode {
    let brick = SKSpriteNode(color:color,size:CGSize(width: width, height:height))
    brick.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: brick.size.width, height: brick.size.height), center: CGPoint(x: brick.size.width/2, y: brick.size.height/2))
    brick.physicsBody?.isDynamic = false
    brick.physicsBody?.restitution = 0
    brick.physicsBody?.contactTestBitMask = 0
    brick.physicsBody?.categoryBitMask = 0
    brick.physicsBody?.collisionBitMask = 0
    brick.zPosition = 2
    brick.anchorPoint = CGPoint(x: 0, y: 0)
    brick.position = Placement
    return brick
    //addChild(brick)
}

var stackedBricks: [SKSpriteNode] = [SKSpriteNode()]

//This function can stack any number of bricks of any size at any position
func stackBricks(NumberOfBricks: Int, StartPosition: CGPoint, brickWidth: Int, brickHeight: Int, color: SKColor, y: CGFloat, x: CGFloat, completionBlock: () -> ()) {
    stackedBricks = [SKSpriteNode()]
    var position = StartPosition
 for _ in 1...NumberOfBricks {
    stackedBricks.append(createBrick(width: brickWidth, height: brickHeight, color: color, Placement: position))
        position.y = position.y + CGFloat(y)
        position.x = position.x + CGFloat(x)
    }
    completionBlock()
}


// create an background with alpha that fades from solid to clear bottom up.
func createColor(width: Int, height: Int, r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat, Placement: CGPoint) -> SKSpriteNode {
    let colorChoice = UIColor(displayP3Red: r, green: g, blue: b, alpha: alpha)
    let colorSwatch = SKSpriteNode(color:colorChoice,size:CGSize(width: width, height:height))
    colorSwatch.zPosition = 3
    colorSwatch.anchorPoint = CGPoint(x: 0, y: 0)
    colorSwatch.position = Placement
//    addChild(colorSwatch)
    return colorSwatch
}


func colorWash (spX: Int, spY: Int, numberOfSwatches: Int, numberOfRows: Int, boxSizeWidth: Int, boxSizeHeight: Int ){
    var position = CGPoint(x: spX,y: spY)
    var alphaChange = 1.0
    var x = 0
    var rows = 0
    func stack(){
        repeat {
            createColor(width: boxSizeWidth, height: boxSizeHeight, r: 1, g: 0, b: 0, alpha: CGFloat(alphaChange), Placement: position)
            position.y = position.y + CGFloat(boxSizeHeight)
            alphaChange -= 0.1
            x+=1
        } while x <= numberOfSwatches
    }
    repeat {
        stack()
        position.y = CGFloat(spY)
        position.x = position.x + CGFloat(boxSizeWidth)
        alphaChange = 1.0
        x=0
        rows+=1
    }   while rows <= numberOfRows
}
