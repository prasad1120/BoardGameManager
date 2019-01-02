//
//  Direction.swift
//  BoardManager
//
//  Created by Prasad on 31/12/18.
//  Copyright © 2018 Prasad Shinde. All rights reserved.
//

import Foundation

public enum Direction: Int {
    case topToBottom = 270
    case bottomToTop = 90
    case leftToRight = 0
    case rightToLeft = 180
    case topRightToBottomLeft = 225
    case topLeftToBottomRight = 315
    case bottomRightToTopLeft = 135
    case bottomLeftToTopRight = 45
    
    static func getDirection (_ first: (x: Int, y: Int), _ second: (x: Int, y: Int)) -> Direction {
        if first.x < second.x {
            if first.y == second.y {
                return .topToBottom
            }
            if first.y < second.y {
                return .topLeftToBottomRight
            }
            return .topRightToBottomLeft
        } else if first.x > second.x {
            if first.y == second.y {
                return .bottomToTop
            }
            if first.y < second.y {
                return .bottomLeftToTopRight
            }
            return .bottomRightToTopLeft
        } else {
            if first.y < second.y {
                return .leftToRight
            } else {
                return .rightToLeft
            }
        }
    }
}
