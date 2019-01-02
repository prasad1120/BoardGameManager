//
//  BoardManager.swift
//  BoardManager
//
//  Created by Prasad on 28/12/18.
//  Copyright © 2018 Prasad Shinde. All rights reserved.
//

import Foundation

public class BoardManager {
    
    public static let shared = BoardManager()
    
    public func getBoard (width : Int, height : Int, rule: BoardTraversingRule) -> Board? {
        if (width < 2 || height < 2 || width > 1000 || height > 1000) {
            return nil
        }
        return Board(width: width, height: height, rule: rule)
    }
}

public enum BoardTraversingRule {
    case orthogonalOnly
    case orthogonalAndDiagonal
}
