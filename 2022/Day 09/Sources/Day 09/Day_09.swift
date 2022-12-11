import Foundation

typealias Rope = [Knot]
enum Direction {
  case up
  case down
  case left
  case right
  case upRight
  case upLeft
  case downRight
  case downLeft
  
  init?(direction: String) {
    switch direction {
      case "U": self = .up
      case "D": self = .down
      case "L": self = .left
      case "R": self = .right
      default: self = .up
    }
  }
}

struct Move {
  let distance: Int
  let direction: Direction
}
struct Position: Hashable {
  var x: Int = 0
  var y: Int = 0
  mutating func moveUp() {
    y += 1
  }
  mutating func moveDown() {
    y -= 1
  }
  mutating func moveLeft() {
    x -= 1
  }
  mutating func moveRight() {
    x += 1
  }
  mutating func moveUpLeft() {
    x -= 1
    y += 1
  }
  mutating func moveUpRight() {
    x += 1
    y += 1
  }
  mutating func moveDownLeft() {
    x -= 1
    y -= 1
  }
  mutating func moveDownRight() {
    x += 1
    y -= 1
  }
}

struct Knot {
  var position: Position = Position()
  
  
  mutating func move(_ direction: Direction) {
    switch direction {
      case .up:
        position.moveUp()
      case .down:
        position.moveDown()
      case .left:
        position.moveLeft()
      case .right:
        position.moveRight()
      case .downLeft:
        position.moveDownLeft()
      case .downRight:
        position.moveDownRight()
      case .upLeft:
        position.moveUpLeft()
      case .upRight:
        position.moveUpRight()
    }
  }
 
  func isTouching(_ otherKnot: Knot) -> Bool{
    let x2 = self.position.x
    let x1 = otherKnot.position.x
    let y2 = self.position.y
    let y1 = otherKnot.position.y
    let distance = Int(sqrt(pow(Double(x2 - x1), 2) + pow(Double(y2 - y1), 2)).rounded(.down))
    return distance <= 1
    
  }
  
  init() {
    self.position = Position()
  }
}

@main
public struct Day_09 {
  static func parse(fileName: String) -> [Move] {
    let pathToFile = FileManager.default.currentDirectoryPath + "/"
    let content = try! String(contentsOfFile: pathToFile + fileName, encoding: .utf8)
    let lines = content.split(separator: "\n")
    return lines.map { Move(distance: Int($0.split(separator: " ").last!)!, direction: Direction(direction: String($0.split(separator: " ").first!))!) }
  }
  
  static func getTailPositionCountsRopeOf(length: Int, for moves: [Move]) -> Int {
    if length < 2 { return 0 }
    var rope = Array(repeating: Knot(), count: length)
    let tail = rope.last!
    var tailPositions: Set<Position> = Set()
    tailPositions.insert(tail.position)
    for move in moves {
      for _ in 0..<move.distance {
        
        rope[0].move(move.direction)
        for i in 1..<rope.count {
          let currentKnot = rope[i]
          let leadingKnot = rope[i - 1]
          
          if currentKnot.isTouching(leadingKnot) {
            continue
          }
          
          if (leadingKnot.position.x > currentKnot.position.x) && (leadingKnot.position.y > currentKnot.position.y) {
            rope[i].move(.upRight)
          } else if (leadingKnot.position.x > currentKnot.position.x) && (leadingKnot.position.y < currentKnot.position.y) {
            rope[i].move(.downRight)
          } else if (leadingKnot.position.x < currentKnot.position.x) && (leadingKnot.position.y < currentKnot.position.y) {
            rope[i].move(.downLeft)
          } else if (leadingKnot.position.x < currentKnot.position.x) && (leadingKnot.position.y > currentKnot.position.y){
            rope[i].move(.upLeft)
          } else if (leadingKnot.position.x > currentKnot.position.x) {
            rope[i].move(.right)
          } else if (leadingKnot.position.x < currentKnot.position.x) {
            rope[i].move(.left)
          } else if (leadingKnot.position.y > currentKnot.position.y) {
            rope[i].move(.up)
          } else if (leadingKnot.position.y < currentKnot.position.y) {
            rope[i].move(.down)
          } else {
            continue
          }
        }
        tailPositions.insert(rope.last!.position)
      }
    }
    return tailPositions.count
  }
  
  
  public static func main() {
    let moves = self.parse(fileName: "test_input.txt")
    print(self.getTailPositionCountsRopeOf(length: 2, for: moves)) //6236
    print(self.getTailPositionCountsRopeOf(length: 10, for: moves)) //2449
  }
}
