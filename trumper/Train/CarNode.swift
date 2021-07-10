//
//  TrainCars.swift
//  trumper
//
//  Created by developer on 8/22/20.
//  Copyright © 2020 administrator. All rights reserved.
//

import Foundation
import SpriteKit


class CarNode: SKNode{
  
    

    private let length: Int
    let anchorPoint: CGPoint = CGPoint(x: 3000, y: 0)
    private var carSegments: [SKNode] = []
    private var platforms: [SKNode] = []
  
    
    
    init(length: Int, anchorPoint: CGPoint, name: String) {
      self.length = length
      super.init()
      self.name = name
    }
    
    required init?(coder aDecoder: NSCoder) {
      length = aDecoder.decodeInteger(forKey: "length")
      super.init(coder: aDecoder)
    }
    
  func addToScene(_ scene: SKScene) {

    zPosition = Layer.train
    scene.addChild(self)
    addChild(locamotive)
    
    var x = 0
    for i in 0..<length {
        let carSegment = SKSpriteNode(color: .clear, size: CGSize(width: 1800, height: 600))
        carSegment.texture = SKTexture(imageNamed: "freightCar\(x+1).png")
       // let texture = SKTexture(imageNamed: "transportCar.pdf")
        let offset = carSegment.size.width * CGFloat(i + 1) + 50
        print(offset)
        
        carSegment.position = CGPoint(x: anchorPoint.x - offset, y: anchorPoint.y)
        carSegment.name = name
        carSegment.anchorPoint = CGPoint(x: 0, y: 0)
        carSegment.physicsBody?.affectedByGravity = false
        carSegments.append(carSegment)
        addChild(carSegment)
        
        carSegment.physicsBody = SKPhysicsBody(rectangleOf: carSegment.size, center: CGPoint(x: carSegment.size.width/2, y: carSegment.size.height/2))
        carSegment.physicsBody?.categoryBitMask = PhysicsCategory.trainCar.rawValue
        carSegment.physicsBody?.collisionBitMask = PhysicsCategory.locamotive.rawValue | PhysicsCategory.solidSurface.rawValue | PhysicsCategory.trainCar.rawValue
        
        
         let platform =  SKSpriteNode(color: .black, size: CGSize(width: 400, height: 20))
        platform.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: platform.size.width, height: platform.size.height), center: CGPoint(x: platform.size.width/2, y: platform.size.height/2))
        platform.zPosition = 2
        platform.name = "platform\(String(x))"
        platform.anchorPoint = CGPoint(x: 0, y: 0)
        platform.physicsBody?.affectedByGravity = false
        platform.physicsBody?.isDynamic = true
        platform.physicsBody?.friction = 0.5
        platform.physicsBody?.restitution = 0.0
        platform.physicsBody?.mass = 0
        platform.physicsBody?.collisionBitMask = 0
        platform.physicsBody?.categoryBitMask = PhysicsCategory.jumpUnderPlatform.rawValue
        platform.position = CGPoint(x: carSegment.position.x+(carSegment.size.width/2)-(platform.size.width/2), y: 50)
        platforms.append(platform)
        addChild(platform)
x+=1
    }
    

    
    
    // set up joint for locamotive and cars
    let joint = SKPhysicsJointPin.joint(
      withBodyA: locamotive.physicsBody!,
      bodyB: carSegments[0].physicsBody!,
      anchor: CGPoint(
        x: locamotive.frame.minX,
        y: locamotive.frame.minY))

    scene.physicsWorld.add(joint)
    
    
    //join platform to locamotive
    let joinPlatform = SKPhysicsJointPin.joint(withBodyA: locamotive.physicsBody!,
                                               bodyB: platforms[0].physicsBody!,
                                               anchor: CGPoint(x: locamotive.frame.minX,
                                                               y: locamotive.frame.minY))
    
    scene.physicsWorld.add(joinPlatform)

    // set up joints between cars
    for i in 1..<length {
      let nodeA = carSegments[i - 1]
      let nodeB = carSegments[i]
      let joint = SKPhysicsJointPin.joint(
        withBodyA: nodeA.physicsBody!,
        bodyB: nodeB.physicsBody!,
        anchor: CGPoint(
          x: nodeA.frame.minX,
          y: nodeA.frame.minY))
      
      scene.physicsWorld.add(joint)
    }
    
    //joints between platforms.
    for i in 1..<length {
      let nodeA = platforms[i - 1]
      let nodeB = platforms[i]
      let joint = SKPhysicsJointPin.joint(
        withBodyA: nodeA.physicsBody!,
        bodyB: nodeB.physicsBody!,
        anchor: CGPoint(
          x: nodeA.frame.minX,
          y: nodeA.frame.minY))
      
      scene.physicsWorld.add(joint)
    }
    
  }
    
    func attachToLocamotive(_ locamotive: SKSpriteNode) {
      // align last segment of vine with prize
      let firstNode = carSegments.first!
        firstNode.position = CGPoint(x: anchorPoint.x,
            y: anchorPoint.y / 2)
          
      // set up connecting joint
      let joint = SKPhysicsJointPin.joint(withBodyA: firstNode.physicsBody!,
                                          bodyB: locamotive.physicsBody!,
                                          anchor: firstNode.position)
          
      locamotive.scene?.physicsWorld.add(joint)
    }
    

    
}

