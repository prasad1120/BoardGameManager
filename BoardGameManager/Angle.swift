//
//  Angle.swift
//  BoardManager
//
//  Created by Prasad on 31/12/18.
//  Copyright © 2018 Prasad Shinde. All rights reserved.
//

import Foundation

public enum Angle : Int {
    case acute = 45
    case right = 90
    case obtuse = 135
    case linear = 180
    case opposite = 0
    
    static func getAngle (_ first : Direction, _ second : Direction) -> Angle {
        let difference = first.rawValue - second.rawValue
        let cosOfAngle : Double
        
        if difference == 0 || difference == 180 || difference == -180 {
            cosOfAngle = cos(Double(abs(difference)).toRadians())
        } else {
            cosOfAngle = cos(Double(abs(180 - (abs(difference)))).toRadians())
        }
        
        if cosOfAngle == cos(Double(Angle.acute.rawValue).toRadians()) {
            return .acute
        } else if cosOfAngle == cos(Double(Angle.right.rawValue).toRadians()) {
            return .right
        } else if cosOfAngle == cos(Double(Angle.obtuse.rawValue).toRadians()) {
            return .obtuse
        } else if cosOfAngle == cos(Double(Angle.linear.rawValue).toRadians()){
            return .linear
        } else {
            return .opposite
        }
    }
}

extension Double {
    func toRadians() -> Double {
        return self * (Double.pi / 180)
    }
}
