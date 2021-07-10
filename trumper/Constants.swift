//
//  physics.swift
//  trumper
//
//  Created by administrator on 1/20/19.
//  Copyright © 2019 administrator. All rights reserved.
//

import Foundation
import SpriteKit

enum PhysicsCategory: UInt32{
    case trump = 1
    case solidSurface = 2
    case eyeOfProvidence = 4
    case jumpUnderPlatform = 8
    case edgeCategory = 16
    case trainCar = 32
    case locamotive = 64
    case solidPlatform = 128
    case barriers = 256
   // case brick = 4
}

enum Layer {
  static let background: CGFloat = 0
  static let train: CGFloat = 1
  static let prize: CGFloat = 2
  static let charecters: CGFloat = 3
    static let foreground: CGFloat = 4
}


enum GameConfiguration {
  static let carDataFile = "CarData.plist"
  static let canCutMultipleVinesAtOnce = false
}

enum Scene {
  static let particles = "Particle.sks"
}
