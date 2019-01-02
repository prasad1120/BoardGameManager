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
    
    init (width : Int, height : Int, rule : BoardTraversingRule) {
        self.width = width
        self.height = height
        self.rule = rule
    }
    
    public func getIndices (from position : Int) -> (x: Int, y: Int)?{
        if !(0..<(height*width)).contains(position) {
            return nil
        }
        let y = position % width
        let x = (position - y) / width
        return (x: x, y: y)
    }
    
    public func getPostion (from indices: (x: Int, y: Int)) -> Int? {
        if isValidIndex(indices) {
            return indices.x * width + indices.y
        }
        return nil
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
                    
                    switch rule! {
                    case .orthogonalAndDiagonal:
                        if (j - 1) >= 0 {
                            adjacentNodes.append([i + 1, j - 1])
                        }
                        if (j + 1) < width {
                            adjacentNodes.append([i + 1, j + 1])
                        }
                    default: break
                    }
                    
                    adjacentNodes.append([i + 1, j])
                }
                adjacencyGraph[[i, j]] = adjacentNodes
            }
        }
        return adjacencyGraph
    }
    
    public func areNeighbours (first : (x : Int, y : Int), second : (x : Int, y : Int))  -> Bool? {
        
        if first == second && !isValidIndex (first, second){
            return nil
        }
        
        var parent, child : (x : Int, y : Int)!
        
        parent = first < second ? first : second
        child = first >= second ? first : second
        
        return indexAdjacencyGraph[[parent.x, parent.y]]!.contains([child.x, child.y])
    }
    
    public func isValidIndex (_ indices : (Int, Int)...) -> Bool{
        
        for index in indices {
            if !((0..<height).contains(index.0) && (0..<width).contains(index.1)) {
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
    
    public func createAndSetRandomString (from set: [Character]) -> String {
        var randomString = ""
        var cumFreq = [Double]()
        var sum = 0.0
        let steps = 1.0 / Double(set.count)
        
        for _ in 0..<set.count {
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
            randomString.append(set[j])
        }
        self.randomString = randomString
        return randomString
    }
    
    public func getAngle (first: (x: Int, y: Int), second: (x: Int, y: Int), third: (x: Int, y: Int)) -> Angle? {
        if first == second || second == third || third == first || !isValidIndex(first, second, third) {
            return nil
        }
        let firstDirection = Direction.getDirection(first, second)
        let secondDirection = Direction.getDirection(second, third)
        
        return Angle.getAngle(firstDirection, secondDirection)
    }
    
    public func getDirection (first: (x: Int, y: Int), second: (x: Int, y: Int)) -> Direction? {
        if first == second || !isValidIndex(first, second) {
            return nil
        }
        return Direction.getDirection(first, second)
    }
    
    public func getSpiralTraversalPath () -> [(x: Int, y: Int)] {
        
        var k = 0, l = 0, m = height!, n = width!, indices = [(x: Int, y: Int)]()
        while k < m && l < n {
            for i in l..<n {
                indices.append((x: k, y: i))
            }
            k += 1
            
            for i in k..<m {
                indices.append((x: i, y: n - 1))
            }
            n -= 1
            
            if k < m {
                var i = n - 1
                while i >= l {
                    indices.append((x: m - 1, y: i))
                    i -= 1
                }
                m -= 1
            }
            
            if l < n {
                var i = m - 1
                while i >= k {
                    indices.append((x: i, y: l))
                    i -= 1
                }
                l += 1
            }
        }
        return indices
    }
    
    public func transform(transformation : Transformation) -> [[(x: Int, y: Int)]] {
        var flippedBoard = Array(repeating: Array(repeating: (x: 0, y: 0), count: height), count: width)
        for i in 0..<width {
            for j in 0..<height {
                switch transformation {
                case .verticalFlip:
                    flippedBoard[i][j] = (x: width - 1 - i, y: j)
                case .horizontalFlip:
                    flippedBoard[i][j] = (x: i, y: height - 1 - j)
                case .topLeftToRightBottomFlip:
                    flippedBoard[i][j] = (x: height - 1 - j, y: width - 1 - i)
                case .topRightToLeftBottomFlip:
                    flippedBoard[i][j] = (x: j, y: i)
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
        if left.1 < right.1 {
            return true
        } else {
            return false
        }
    }
}

func == (left: (Int, Int), right: (Int, Int)) -> Bool {
    if left.0 == right.0 && left.1 == right.1 {
        return true
    }
    return false
}


public enum Transformation {
    case horizontalFlip
    case verticalFlip
    case topLeftToRightBottomFlip
    case topRightToLeftBottomFlip
}
