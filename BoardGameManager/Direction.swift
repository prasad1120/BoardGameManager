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
    
    static func getDirection (_ first: (a: Int, b: Int), _ second: (a: Int, b: Int)) -> Direction? {
        if first.a < second.a {
            if first.b == second.b {
                return .topToBottom
            }
            if first.b < second.b {
                return .topLeftToBottomRight
            }
            return .topRightToBottomLeft
        } else if first.a > second.a {
            if first.b == second.b {
                return .bottomToTop
            }
            if first.b < second.b {
                return .bottomLeftToTopRight
            }
            return .bottomRightToTopLeft
        } else {
            if first.b < second.b {
                return .leftToRight
            } else if first.b > second.b {
                return .rightToLeft
            } else {
                return nil
            }
        }
    }
}
