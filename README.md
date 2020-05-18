# BoardGameManager
[![Version](https://img.shields.io/cocoapods/v/BoardGameManager.svg)](https://cocoapods.org/pods/BoardGameManager)
[![Platform](https://img.shields.io/cocoapods/p/BoardGameManager.svg)](https://cocoapods.org/pods/BoardGameManager)
![GitHub top language](https://img.shields.io/github/languages/top/prasad1120/BoardGameManager)
[![License](https://img.shields.io/github/license/prasad1120/BoardGameManager.svg?style=flat)](./LICENSE)

BoardGameManager is a Cocoapod that helps with score calculation, transformation and traversal in board games on iOS. It gives the direction and angles between nodes in trails on the board which can be used for score calculation (Weirder the angle, higher the score). It has spiral traversal and various flipping and rotational transformations. 

## Requirements 
- Swift 4.2
- iOS 10 and above

## Installation
BoardGameManager is available on [CocoaPods](https://cocoapods.org/pods/BoardGameManager).

Add this line to your `Podfile`.
~~~
pod 'BoardGameManager'
~~~
Run `pod install`.

## Usage
Create a board
~~~swift
let board = Board(height: 5, width: 3, rule: .orthogonalAndDiagonal)
~~~
### List of methods:
~~~swift
areNeighbours(first : (a: Int, b: Int), second : (a: Int, b: Int))  -> Bool?
~~~
~~~swift
createAndSetRandomString (from set: [Character]? = nil) -> String
~~~
~~~swift
createAndSetRandomStringUsingLetterFrequency() -> String
~~~
~~~swift
isValidIndex(_ indices : (Int, Int)...) -> Bool
~~~
~~~swift
getAngle(first: (x: Int, y: Int), second: (x: Int, y: Int), third: (x: Int, y: Int)) -> Angle?
~~~
~~~swift
getDirection(first: (x: Int, y: Int), second: (x: Int, y: Int)) -> Direction?
~~~
~~~swift
getHeight() -> Int
~~~
~~~swift
getIndices(from position : Int) -> (a: Int, b: Int)?
~~~
~~~swift
getPosition(from indices: (a: Int, b: Int)) -> Int?
~~~
~~~swift
getSpiralTraversalPath() -> [(x: Int, y: Int)]
~~~
~~~swift
getWidth() -> Int
~~~
~~~swift
transform(transformation : Transformation) -> [[(x: Int, y: Int)]]
~~~





## License
This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details



