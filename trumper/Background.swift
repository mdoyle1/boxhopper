//
//  Background.swift
//  trumper
//
//  Created by administrator on 1/21/19.
//  Copyright © 2019 administrator. All rights reserved.
//

import Foundation
import SpriteKit


let background = SKSpriteNode(imageNamed: "background")
var mainBackgroundXposition: CGFloat = 0

func backgroundScene(frame:CGRect) -> SKSpriteNode {
  //  addChild(background)
    background.anchorPoint = CGPoint(x:0,y:0)
    background.position = frame.origin
    background.zPosition = 0
    background.physicsBody?.friction = 0
    return background
}

func startOfScene(frame:CGRect) -> SKShapeNode {
    let endOfSceneRect = SKShapeNode(rectOf:CGSize(width:frame.width, height:frame.height)) // Create circle
        endOfSceneRect.zPosition = 0
    endOfSceneRect.position = CGPoint(x: frame.width * -1, y: 0) // Center (given scene anchor point is 0.5 for x&y)
      //  endOfSceneRect.strokeColor = SKColor.black
        endOfSceneRect.glowWidth = 1.0
        endOfSceneRect.fillColor = SKColor.white
        //self.addChild(Circle)
        return endOfSceneRect
}

func endOfScene(frame:CGRect) -> SKShapeNode {
    let endOfSceneRect = SKShapeNode(rectOf:CGSize(width:frame.width, height:frame.height)) // Create circle
        endOfSceneRect.zPosition = 0
        endOfSceneRect.position = CGPoint(x: background.size.width, y: 0) // Center (given scene anchor point is 0.5 for x&y)
      //  endOfSceneRect.strokeColor = SKColor.black
        endOfSceneRect.glowWidth = 1.0
        endOfSceneRect.fillColor = SKColor.white
        //self.addChild(Circle)
        return endOfSceneRect
}



//func slideBackgroundLeft(xPosition: CGFloat, backdrop: SKSpriteNode, frame: CGRect){
//        //Move background left to make sceen appear to go forward...
//        if xPosition > frame.origin.x {
//            backdrop.position.x = frame.origin.x
//        }else if xPosition < frame.origin.x {
//            backdrop.run(SKAction.repeatForever(.moveBy(x: -80, y: 0, duration: 1)),withKey:"slideLeft")
//        }
//    }
//    
//    func slideBackgroundRight(xPosition: CGFloat, backdrop: SKSpriteNode, frame: CGRect){
//        if xPosition < frame.origin.x {
//            backdrop.run(SKAction.repeatForever(.moveBy(x: 80, y: 0, duration: 1)),withKey: "slideRight")
//        }else if xPosition > frame.origin.x {
//            backdrop.position.x = frame.origin.x
//        }}
//

class BackgroundNode : SKNode {
    
    public func setup(size : CGSize) {
        let yPos : CGFloat = 0
        let startPoint = CGPoint(x:-400, y: yPos)
        let endPoint = CGPoint(x: size.width, y: yPos)
        physicsBody = SKPhysicsBody(edgeFrom: startPoint, to: endPoint)
        physicsBody?.restitution = 0.3
        
    }
}
        

    

