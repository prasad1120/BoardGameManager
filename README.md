# BoardGameManager
[![Version](https://img.shields.io/cocoapods/v/BoardGameManager.svg)](https://cocoapods.org/pods/BoardGameManager)
[![Platform](https://img.shields.io/cocoapods/p/BoardGameManager.svg)](https://cocoapods.org/pods/BoardGameManager)
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
let board = BoardManager.shared.getBoard(width: 3, height: 3, rule: BoardTraversingRule.orthogonalOnly)
~~~
### List of methods in `Board`

- `getAngle (first: (x: Int, y: Int), second: (x: Int, y: Int), third: (x: Int, y: Int)) -> Angle?`

- `getDirection (first: (x: Int, y: Int), second: (x: Int, y: Int)) -> Direction?`

- `transform(transformation : Transformation) -> [[(x: Int, y: Int)]]`

- `areNeighbours (first : (a: Int, b: Int), second : (a: Int, b: Int))  -> Bool?`

- `getSpiralTraversalPath () -> [(x: Int, y: Int)]`

- `createAndSetRandomStringUsingLetterFrequency () -> String`

- `createAndSetRandomString (from set: [Character]) -> String`

- `getIndices (from position : Int) -> (a: Int, b: Int)?`

- `getPosition (from indices: (a: Int, b: Int)) -> Int?`

- `isValidIndex (_ indices : (Int, Int)...) -> Bool`




## License
This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details



