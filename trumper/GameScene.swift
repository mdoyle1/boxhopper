//
//  GameScene.swift
//  trumper
//
//  Created by administrator on 1/17/19.
//  Copyright © 2019 administrator. All rights reserved.
//https://medium.com/@andreasorrentino/understanding-collisions-in-spritekit-swift-4-and-ios-11-ce62de4801cc
//https://www.youtube.com/watch?v=0gOi_2Jwt28
//https://www.raywenderlich.com/5347797-how-to-make-a-game-like-cut-the-rope-with-spritekit

import SpriteKit
import GameplayKit



let playerA = PlayerA()
let trainPlatform = TrainPlatform()
let locamotive = Locamotive()
let railroadcrossing = RailroadCrossing()

   

//Track what platforms playerA comes in contact with
var platformName:String = String()



class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var particles: SKEmitterNode?
    private var didReleaseHitch:Bool = false
    private var trainSpeed:Double = 200
    private var passSwitch:Bool = true
    
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()

    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?

    private let leftBarrier = Switches()
    private let rightBarrier = Switches()
    private let leftSpeedSwitch = Switches()
    private let rightSpeedSwitch = Switches()
    private let centerSpeedSwitch = Switches()
    
    let fm = FileManager.default
    
    var increment: Int = 0
    private let backgroundNode = BackgroundNode()
    //let platform = createBrick(width: 300, height: 10, color: .black, Placement: CGPoint(x: -7800, y:-330))
    //let platformTest = createBrick(width: 300, height: 10, color: .black, Placement: CGPoint(x: 300, y:-330))
    //let platform = createBrick(width: 300, height: 10, color: .black, Placement: CGPoint(x: 0, y:-330))
   let efforts = eyeOfProvidence(image: "efforts", position: CGPoint(x: 500, y: 300), size: CGSize(width: 200, height: 400))
    
    func setupScene(){
        let decoder = PropertyListDecoder()
        guard
          let dataFile = Bundle.main.url(
            forResource: GameConfiguration.carDataFile,
            withExtension: nil),
          let data = try? Data(contentsOf: dataFile),
          let cars = try? decoder.decode([sceneData].self, from: data)
          else {
            return
        }
        
        // 1 add cars
        for (i, carData) in cars.enumerated() {
          let anchorPoint = CGPoint(
            x: carData.relAnchorPoint.x * size.width,
            y: carData.relAnchorPoint.y * size.height)
          let trainCars = CarNode(
            length: carData.length,
            anchorPoint: anchorPoint,
            name: "car\(i)")

          // 2 add to scene
          trainCars.physicsBody?.affectedByGravity = false
          trainCars.addToScene(self)

          // 3 connect the other end of the vine to the prize
        // trainCars.attachToLocamotive(locamotive)
        }
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        print("bodyA = \(contact.bodyA.node!.name ?? "empty")")
        print("bodyB = \(contact.bodyB.node!.name ?? "empty")")
       
        
        if contact.bodyB.node!.name!.contains("platform") && playerA.position.y > 230 {
            jumpWasPressed = false
          
            platformName = contact.bodyB.node!.name!
            contact.bodyB.categoryBitMask = PhysicsCategory.solidPlatform.rawValue
            contact.bodyB.collisionBitMask = PhysicsCategory.solidPlatform.rawValue
        }
        else if contact.bodyB.node!.name!.contains("platform") && playerA.position.y < 230{
            contact.bodyB.categoryBitMask = PhysicsCategory.jumpUnderPlatform.rawValue
            contact.bodyB.collisionBitMask = PhysicsCategory.jumpUnderPlatform.rawValue
        }
  
        if contact.bodyA.node!.name == "floor" && contact.bodyB.node!.name == "trumper" {
            jumpWasPressed = false
                    
                  }
        
        if contact.bodyA.node!.name == "barriers" && contact.bodyB.node!.name == "locamotive" {
            trainSpeed = (trainSpeed * -1)
            if passSwitch {
                passSwitch.toggle()
                trainSpeed = trainSpeed*2
            }
        }
    }

    
    func didEnd(_ contact: SKPhysicsContact) {
        
        if contact.bodyB.node!.name!.contains("platform") && contact.bodyA.node!.name! == "trumper" {
            contact.bodyB.categoryBitMask = PhysicsCategory.jumpUnderPlatform.rawValue
            contact.bodyB.collisionBitMask = PhysicsCategory.jumpUnderPlatform.rawValue
        }
      
    
        if contact.bodyA.node!.name == "speedSwitch" && contact.bodyB.node!.name == "locamotive" {
            passSwitch.toggle()
            if passSwitch {
            trainSpeed = trainSpeed / 2
            } else {
                trainSpeed = trainSpeed * 2
            }
          }
    }
    
        
    override func didMove(to view: SKView) {
        self.anchorPoint=CGPoint(x:0,y:0)
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
 
        print("HERE ARE THE SCENE DIMENSIONS...")
        print(background.size.width)
        print(background.frame.size.width)
        print(background.size.height)

        //MARK: -SCENE
        addChild(cameraSetup(frame: frame))
        addChild(backgroundScene(frame:frame))
      //  addChild(startOfScene(frame: frame))
      //  addChild(endOfScene(frame: frame))

       
        leftBarrier.position = CGPoint(x: -3000, y: 0)
        addChild(leftBarrier)
        
        rightBarrier.position = CGPoint(x: 10000, y: 0)
        addChild(rightBarrier)
        
        leftSpeedSwitch.name = "speedSwitch"
        leftSpeedSwitch.position = CGPoint(x: -100, y: 0)
        leftSpeedSwitch.xPosition = 4
      
        leftSpeedSwitch.physicsBody?.categoryBitMask = 0
        addChild(leftSpeedSwitch)
        
        rightSpeedSwitch.name = "speedSwitch"
        rightSpeedSwitch.xPosition = 4
        rightSpeedSwitch.position = CGPoint(x: 6000, y: 0)
        rightSpeedSwitch.physicsBody?.categoryBitMask = 0
        addChild(rightSpeedSwitch)
        
        centerSpeedSwitch.name = "speedSwitch"
        centerSpeedSwitch.xPosition = 4
        centerSpeedSwitch.position = CGPoint(x:2000, y: 0)
        centerSpeedSwitch.physicsBody?.categoryBitMask = 0
        addChild(centerSpeedSwitch)
        addChild(efforts)
        addChild(createFloor(frame:frame))
        
        
        addChild(playerA)
      
        setupScene()
    }

   
    override func sceneDidLoad() {
        self.lastUpdateTime = 0
       // debugDrawPlayableArea()
        }
        
    
    
    
    
    func touchDown(atPoint pos : CGPoint) {
        print("touched @ x=\(pos.x)")
        print("touched @ y=\(pos.y)")
        //onPlatform = false
    
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
      for touch in touches {
        let startPoint = touch.location(in: self)
        let endPoint = touch.previousLocation(in: self)

        showMoveParticles(touchPosition: startPoint)
      }
    }
    
    
    func touchUp(atPoint pos : CGPoint) {
      
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        
        touchLogic(touches: touches, self: self, xPos: playerA.position.x, platform:trainPlatform)
        
        for t in touches { self.touchDown(atPoint: t.location(in: self))
          
        }
    }
    

    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
        playerA.xVelocity = 0
        playerA.yVelocity = 0

        playerA.removeAllActions()
        particles?.removeFromParent()
        particles = nil
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    private func showMoveParticles(touchPosition: CGPoint) {
      if particles == nil {
        particles = SKEmitterNode(fileNamed: Scene.particles)
        particles!.zPosition = 4
        particles!.targetNode = self
        addChild(particles!)
      }
      particles!.position = touchPosition
    }
    
    
    override func update(_ currentTime: TimeInterval) {
     
//        playerAXposition = playerA.position.x
//        playerAYposition = playerA.position.y
      
        locamotive.physicsBody?.velocity = CGVector(dx: trainSpeed, dy: 0.0)
        platformMotion(platform: trainPlatform, frameWidth: self.frame.size.width)
       // platformMotion(platform: item, frameWidth: self.frame.size.width)
        playerPhysicalMovement(player:playerA)
        
        
        
      //  print(platform.position.x)
       // print(cam.position.x)
  
//        if trump.position.x > CGFloat(600) {
//           zoomIn()
//        }
//
//        if trump.position.x < CGFloat(600) {
//            zoomOut()
//        }
//        
//        if trump.position.x > CGFloat(600) {
//               effortsSpin(image: "efforts", sprite: efforts)
//           }
//           if trump.position.x < CGFloat(600) {
//               reverseEfforts(image: "efforts", sprite: efforts)
//           }
//        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
        
        cam.position.x = playerA.position.x
        cam.position.y = playerA.position.y
        mainBackgroundXposition = background.position.x
        if playerA.position.x < frame.origin.x+100{
            playerA.position.x = frame.origin.x+100
            
        }
        
        if playerA.position.x > background.size.width-(frame.size.width/2)-100{
            playerA.position.x = background.size.width-(frame.size.width/2)-100
        }
        
    }
    
    
    //MARK: - Game logic
    
    private func checkIfHitchIsReleased(withBody body: SKPhysicsBody) {
      if didReleaseHitch && !GameConfiguration.canCutMultipleVinesAtOnce {
        return
      }
      
      let node = body.node!

      // if it has a name it must be a vine node
      if let name = node.name {
        // snip the vine
        node.removeFromParent()

        // fade out all nodes matching name
        enumerateChildNodes(withName: name, using: { node, _ in
          let fadeAway = SKAction.fadeOut(withDuration: 0.25)
          let removeNode = SKAction.removeFromParent()
          let sequence = SKAction.sequence([fadeAway, removeNode])
          node.run(sequence)
        })
        
       // crocodile.removeAllActions()
        //crocodile.texture = SKTexture(imageNamed: ImageName.crocMouthOpen)
       // animateCrocodile()
       // run(sliceSoundAction)
        didReleaseHitch = true
      }
    }
}
