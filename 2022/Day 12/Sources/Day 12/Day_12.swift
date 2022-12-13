import Foundation

class Node {
  var value: Int
  var rawValue: String
  var neighbors: [Node]
  var isStart: Bool
  var isEnd: Bool
  var path: [Node]
  var visited: Bool
  var isOnEdge: Bool

  init(value: String) {
    self.value = value == "S" ? 0 : value == "E" ? 26 : Int(Character(value).asciiValue! % 97)
    self.neighbors = []
    self.isStart = value == "S"
    self.isEnd = value == "E"
    self.rawValue = value
    self.path = []
    self.visited = false
    self.isOnEdge = true
  }
}

@main
public struct Day_12 {
  static func parse(fileName: String) -> [[String]] {
    let pathToFile = FileManager.default.currentDirectoryPath + "/"
    let content = try! String(contentsOfFile: pathToFile + fileName, encoding: .utf8)
    var nodes: [[String]] = []
    for line in content.split(separator: "\n") {
      var row: [String] = []
      for character in line {
        row.append(String(character))
      }
      nodes.append(row)
      row.removeAll()
    }
    return nodes
  }
  
  static func makeGraphFrom(_ hill: [[String]]) -> [[Node]] {

    var nodeArray: [[Node]] = []
    
    for x in hill {
      var row: [Node] = []
      for y in x {
       
        row.append(Node(value: y))
      }
      nodeArray.append(row)
      row.removeAll()
    }
    
    
    for x in 0..<nodeArray.count {
      for y in 0..<nodeArray[x].count {
        let node = nodeArray[x][y]
        if x == 0 && y == 0 { // Top Left
          node.neighbors.append(nodeArray[x + 1][y])
          node.neighbors.append(nodeArray[x][y + 1])
        } else if x == nodeArray.count - 1 && y == 0 { // Bottom Left {
          node.neighbors.append(nodeArray[x - 1][y])
          node.neighbors.append(nodeArray[x][y + 1])
        } else if x == 0 && y == nodeArray[x].count - 1 { // Top Right
          node.neighbors.append(nodeArray[x][y - 1])
          node.neighbors.append(nodeArray[x + 1][y])
        } else if x == nodeArray.count - 1 && y == nodeArray[x].count - 1 { //Bottom Right
          node.neighbors.append(nodeArray[x][y - 1])
          node.neighbors.append(nodeArray[x - 1][y])
        } else if y == 0 { // Left Side
          node.neighbors.append(nodeArray[x][y + 1])
          node.neighbors.append(nodeArray[x - 1][y])
          node.neighbors.append(nodeArray[x + 1][y])
        } else if y == nodeArray[x].count - 1 { // Right Side
          node.neighbors.append(nodeArray[x][y - 1])
          node.neighbors.append(nodeArray[x - 1][y])
          node.neighbors.append(nodeArray[x + 1][y])
        } else if x == 0 { // Top Side
          node.neighbors.append(nodeArray[x + 1][y])
          node.neighbors.append(nodeArray[x][y + 1])
          node.neighbors.append(nodeArray[x][y - 1])
        } else if x == nodeArray.count - 1 { // Bottom Side
          node.neighbors.append(nodeArray[x - 1][y])
          node.neighbors.append(nodeArray[x][y + 1])
          node.neighbors.append(nodeArray[x][y - 1])
        } else {
          node.isOnEdge = false
          node.neighbors.append(nodeArray[x + 1][y])
          node.neighbors.append(nodeArray[x - 1][y])
          node.neighbors.append(nodeArray[x][y + 1])
          node.neighbors.append(nodeArray[x][y - 1])
        }
      }
    }
    return nodeArray
  }
  
  static func problem1(hill: [[String]]) -> Int {
    
    let graph = makeGraphFrom(hill).reduce([], + ).first(where: { $0.rawValue == "S" })!
    
    var queue: [Node] =  []
    graph.visited = true
    queue.append(graph)
    var shortestPath = Int.max
    while !queue.isEmpty {
      let currentNode = queue.removeFirst()
      if currentNode.isEnd {
        let length = currentNode.path.count
        if shortestPath > length { shortestPath = length}
       
      }
      for neighbor in currentNode.neighbors {
        if currentNode.value == neighbor.value - 1 || currentNode.value >= neighbor.value {
          if neighbor.visited { continue }
          neighbor.visited = true
          neighbor.path.append(contentsOf: currentNode.path)
          neighbor.path.append(currentNode)
          queue.append(neighbor)

        }
      }
    }
    return shortestPath
  }
  
  static func problem2(hill: [[String]]) -> Int {
    
    let graph = makeGraphFrom(hill).reduce([], + ).first(where: {$0.isEnd})!

    var queue: [Node] =  []
    graph.visited = true
    queue.append(graph)
    var shortestPath = Int.max
    while !queue.isEmpty {
      let currentNode = queue.removeFirst()
      if currentNode.isOnEdge && currentNode.value == 0 {
        let length = currentNode.path.count
        if shortestPath > length { shortestPath = length}
        
      }
      for neighbor in currentNode.neighbors {
        if currentNode.value - 1 == neighbor.value || currentNode.value <= neighbor.value {
          if neighbor.visited { continue }
          neighbor.visited = true
          neighbor.path.append(contentsOf: currentNode.path)
          neighbor.path.append(currentNode)
          queue.append(neighbor)
          
        }
      }
    }
    return shortestPath
  }
  public static func main() {
    let hill = parse(fileName: "input.txt")
    print(problem1(hill: hill))
    print(problem2(hill: hill))
  }
}

