//
//  camera.swift
//  trumper
//
//  Created by administrator on 1/26/19.
//  Copyright © 2019 administrator. All rights reserved.
//

import Foundation
import SpriteKit

var iPad : Bool {
    return UIDevice.current.model.contains("iPad")
}

let cam = SKCameraNode()
extension GameScene {


func cameraSetup(frame:CGRect) -> SKCameraNode {
    //Cameral will be refrencing the backgroud
    //
    let screenSize = UIScreen.main.bounds
    print("screen size = \(screenSize.height)")
     print(UIScreen.main.scale)
    print(frame.size.height)
    print(cam.position.y)
   
    
    if iPad {
        print("Using iPad")
        print(UIScreen.main.scale)
    }
    self.camera = cam
    
    //Setup camera constraints
    let horizontalRange = SKConstraint .distance(SKRange(upperLimit: 0), to: playerA)
    let verticalRange = SKConstraint .distance(SKRange(upperLimit: 0), to:playerA)
    let leftConstraint = SKConstraint .positionX(SKRange(lowerLimit:cam.position.x))
    let bottomConstraint = SKConstraint .positionY(SKRange(lowerLimit:cam.position.y + (screenSize.width/2)))
    let rightConstraint = SKConstraint .positionX(SKRange(upperLimit:(background.size.width-frame.width-cam.position.x)))
    let topConstraint = SKConstraint .positionY(SKRange(upperLimit:(background.frame.size.height-cam.position.y)))
    cam.constraints = [horizontalRange, verticalRange, leftConstraint, bottomConstraint, rightConstraint, topConstraint]
    cam.zPosition = 0
    //TO ADJUST THE CAMERA ZOOM ADJUST THE X AND Y SCALE
    cam.xScale = 2
    cam.yScale = 2
    print("here is the bottomConstraint")
       print(cam.position.y + ((screenSize.height + playerA.size.height) / 2))
    //cam.run(SKAction.scale(to: 2, duration: 1))
    return cam
}

func zoomIn() {
    let zoomInAction = SKAction.scale(to: 0.75, duration: 1)
    cam.run(zoomInAction)
}
func zoomOut() {
    let zoomInAction = SKAction.scale(to: 1, duration: 1)
    cam.run(zoomInAction)
}

}
