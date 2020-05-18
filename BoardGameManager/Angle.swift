//
//  Angle.swift
//  BoardManager
//
//  Created by Prasad on 31/12/18.
//  Copyright © 2018 Prasad Shinde. All rights reserved.
//

import Foundation

public enum Angle : Int, CaseIterable {
    case acute = 45
    case right = 90
    case obtuse = 135
    case linear = 0
    case opposite = 180
    
    static func getAngle (_ first : Direction, _ second : Direction) -> Angle? {
        let difference = first.rawValue - second.rawValue
        let cosOfAngle : Double
        
        if difference == 0 || difference == 180 || difference == -180 {
            cosOfAngle = cos(Double(abs(difference)).toRadians())
        } else {
            cosOfAngle = cos(Double(abs(180 - (abs(difference)))).toRadians())
        }
        
        for angle in Angle.allCases where cosOfAngle == cos(Double(angle.rawValue).toRadians()) {
            return angle
        }
        return nil
    }
}

extension Double {
    func toRadians() -> Double {
        return self * (Double.pi / 180)
    }
}
