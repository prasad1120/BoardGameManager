//
//  Board.swift
//  BoardManager
//
//  Created by Prasad on 28/12/18.
//  Copyright © 2018 Prasad Shinde. All rights reserved.
//

import Foundation

public class Board {
    
    private var width : Int!
    private var height : Int!
    private var rule : BoardTraversingRule!
    private let cumulativeFrequency = [0.08167, 0.09659000000000001, 0.12441, 0.16694, 0.29396, 0.31624, 0.33639, 0.39733, 0.46699, 0.46852, 0.47624, 0.51649, 0.54055, 0.6080399999999999, 0.6831099999999999, 0.7023999999999999, 0.7033499999999999, 0.7632199999999999, 0.82649, 0.9170499999999999, 0.94463, 0.95441, 0.9780099999999999, 0.9795099999999999, 0.9992499999999999, 0.9999999999999]
    public var randomString : String?
    
    private(set) lazy var  indexAdjacencyGraph : [[Int] : [[Int]]] = {
        return createIndexAdjacencyGraph()
    }()
    
    public enum BoardTraversingRule {
        case orthogonalOnly
        case orthogonalAndDiagonal
    }
    
    public enum Transformation {
        case horizontalFlip
        case verticalFlip
        case topLeftToRightBottomFlip
        case topRightToLeftBottomFlip
        case leftRotate
        case rightRotate
    }
    
    public init? (height : Int, width: Int, rule : BoardTraversingRule) {
        if (width < 2 || height < 2 || width > 1000 || height > 1000) {
            return nil
        }
        self.width = width
        self.height = height
        self.rule = rule
    }
    
    public func getWidth() -> Int {
        return width
    }
    
    public func getHeight() -> Int {
        return height
    }
    
    public func getIndices (from position : Int) -> (a: Int, b: Int)?{
        guard (0..<(height*width)).contains(position) else {
            return nil
        }
        let b = position % width
        let a = (position - b) / width
        return (a: a, b: b)
    }
    
    public func getPosition (from indices: (a: Int, b: Int)) -> Int? {
        return isValidIndex(indices) ? (indices.a * width + indices.b) : nil
    }
    
    func createIndexAdjacencyGraph () -> [[Int] : [[Int]]] {
        
        var adjacencyGraph = [[Int] : [[Int]]]()
        for i in 0..<height {
            for j in 0..<width {
                var adjacentNodes = [[Int]]()
                
                if (j + 1) < width {
                    adjacentNodes.append([i, j + 1])
                }
                
                if (i + 1) < height {
                    if rule == .orthogonalAndDiagonal {
                        if (j - 1) >= 0 {
                            adjacentNodes.append([i + 1, j - 1])
                        }
                        if (j + 1) < width {
                            adjacentNodes.append([i + 1, j + 1])
                        }
                    }
                    adjacentNodes.append([i + 1, j])
                }
                adjacencyGraph[[i, j]] = adjacentNodes
            }
        }
        return adjacencyGraph
    }
    
    public func areNeighbours (first : (a : Int, b : Int), second : (a : Int, b : Int))  -> Bool? {
        
        guard first != second,
            isValidIndex(first, second) else {
                return nil
        }
        
        var parent, child : (a : Int, b : Int)!
        
        if first < second {
            parent = first
            child = second
        } else {
            parent = second
            child = first
        }
        
        return indexAdjacencyGraph[[parent.a, parent.b]]!.contains([child.a, child.b])
    }
    
    public func isValidIndex (_ indices : (Int, Int)...) -> Bool{
        
        for index in indices {
            guard (0..<height).contains(index.0),
                (0..<width).contains(index.1) else {
                    return false
            }
        }
        return true
    }
    
    public func createAndSetRandomStringUsingLetterFrequency () -> String {
        var randomString = ""
        for _ in 0..<(height * width) {
            let random = Double.random(in: 0.0...1.0)
            var j = 0
            while cumulativeFrequency[j] < random {
                j += 1
            }
            randomString.append(Character(UnicodeScalar(j + 65)!))
        }
        self.randomString = randomString
        return randomString
    }
    
    public func createAndSetRandomString (from set: [Character]? = nil) -> String {
        var randomString = ""
        var cumFreq = [Double]()
        var sum = 0.0
        let steps = 1.0 / Double(set?.count ?? 26)
        
        for _ in 0..<(set?.count ?? 26) {
            sum += steps
            cumFreq.append(sum)
        }
        cumFreq[cumFreq.endIndex - 1] = 1.0
        
        for _ in 0..<(height * width) {
            let random = Double.random(in: 0.0...1.0)
            var j = 0
            while cumFreq[j] < random {
                j += 1
            }
            randomString.append(set?[j] ?? Character(UnicodeScalar(j + 65)!))
        }
        self.randomString = randomString
        return randomString
    }
    
    public func getAngle (first: (a: Int, b: Int), second: (a: Int, b: Int), third: (a: Int, b: Int)) -> Angle? {
        guard isValidIndex(first, second, third),
            let firstDirection = Direction.getDirection(first, second),
            let secondDirection = Direction.getDirection(second, third) else {
            return nil
        }
        
        return Angle.getAngle(firstDirection, secondDirection)
    }
    
    public func getDirection (first: (a: Int, b: Int), second: (a: Int, b: Int)) -> Direction? {
        guard isValidIndex(first, second) else {
            return nil
        }
        return Direction.getDirection(first, second)
    }
    
    public func getSpiralTraversalPath () -> [(a: Int, b: Int)] {
        
        var k = 0, l = 0, m = height!, n = width!, indices = [(a: Int, b: Int)]()
        while k < m && l < n {
            for i in l..<n {
                indices.append((a: k, b: i))
            }
            k += 1
            
            for i in k..<m {
                indices.append((a: i, b: n - 1))
            }
            n -= 1
            
            if k < m {
                var i = n - 1
                while i >= l {
                    indices.append((a: m - 1, b: i))
                    i -= 1
                }
                m -= 1
            }
            
            if l < n {
                var i = m - 1
                while i >= k {
                    indices.append((a: i, b: l))
                    i -= 1
                }
                l += 1
            }
        }
        return indices
    }
    
    public func transform(transformation : Transformation) -> [[(a: Int, b: Int)]] {
        var newHeight, newWidth : Int!
        
        switch transformation {
        case .verticalFlip, .horizontalFlip:
            newWidth = width
            newHeight = height
        default:
            newWidth = height
            newHeight = width
        }
        var flippedBoard = Array(repeating: Array(repeating: (a: 0, b: 0), count: newWidth), count: newHeight)
        
        for i in 0..<newHeight {
            for j in 0..<newWidth {
                switch transformation {
                case .verticalFlip:
                    flippedBoard[i][j] = (a: newHeight - 1 - i, b: j)
                case .horizontalFlip:
                    flippedBoard[i][j] = (a: i, b: newWidth - 1 - j)
                case .topLeftToRightBottomFlip:
                    flippedBoard[i][j] = (a: newWidth - 1 - j, b: newHeight - 1 - i)
                case .topRightToLeftBottomFlip:
                    flippedBoard[i][j] = (a: j, b: i)
                case .leftRotate:
                    flippedBoard[i][j] = (a: newWidth - 1 - j, b: i)
                case .rightRotate:
                    flippedBoard[i][j] = (a: j, b: newHeight - 1 - i)
                }
            }
        }
        return flippedBoard
    }
}

func < (left: (Int, Int), right: (Int, Int)) -> Bool {
    if left.0 < right.0 {
        return true
    } else if left.0 > right.0 {
        return false
    } else {
        return left.1 < right.1
    }
}

func == (left: (Int, Int), right: (Int, Int)) -> Bool {
    return left.0 == right.0 && left.1 == right.1
}

