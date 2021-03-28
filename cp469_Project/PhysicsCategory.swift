//
//  File.swift
//  CollisionDetection
//
//  Created by Chinh T Hoang on 2015-02-24.
//  Copyright (c) 2015 wlu. All rights reserved.
//

struct PhysicsCategory {
    static let None      : UInt32 = 0
    static let All       : UInt32 = UInt32.max
    static let Walls   : UInt32 = 0b1       // 1
    static let Player: UInt32 = 0b10      // 2
    static let Minotaur    : UInt32 = 0b100      // 4

}
