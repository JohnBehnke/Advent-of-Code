import Foundation

typealias Forest = [[Tree]]
class Tree: CustomStringConvertible, Comparable {
  static func == (lhs: Tree, rhs: Tree) -> Bool {
    lhs.height == rhs.height
  }

  static func < (lhs: Tree, rhs: Tree) -> Bool {
    return lhs.height < rhs.height
  }

  var height: Int = 0
  var isVisisbleFromAnEdge: Bool = false
  var scenicScore: Int = 0
  
  init(height: Int) {
    self.height = height
  }
  
  var description: String {
    return "\(isVisisbleFromAnEdge ? "\u{001B}[0;32m" : "")\(height) \(isVisisbleFromAnEdge ? "\u{001B}[0;0m" : "")"
  }
}
@main
public struct Day_08 {
  
  func rotate(forest: Forest) -> Forest {
    var columns: [[Tree]] = []
    for x in 0..<forest.count {
      var column: [Tree] = []
      for y in 0..<forest[x].count {
        column.append(forest[y][x])
      }
      columns.append(column)
      column.removeAll()
    }
    return columns
  }
  
  func parse(fileName: String) -> Forest {
    let pathToFile = FileManager.default.currentDirectoryPath + "/"
    let content = try! String(contentsOfFile: pathToFile + fileName, encoding: .utf8)
    let lines = content.split(separator: "\n").map { String($0) }
    var trees: [[Tree]] = []
    for line in lines {
      var row: [Tree] = []
      for char in line {
        row.append(Tree(height: Int(String(char)) ?? 0))
      }
      trees.append(row)
      row.removeAll()
    }
    
    for x in 0..<trees.count {
      for y in 0..<trees[x].count {
        if (x == 0 || x == trees.count - 1 ) || (y == 0 || y == trees[x].count - 1) {
          trees[x][y].isVisisbleFromAnEdge = true
        }
      }
    }
    return trees
  }
  
  func problem1(forest: Forest) -> Int {
    let rotatedForest = rotate(forest: forest)
    for x in 1..<forest.count - 1{
      for y in 1..<forest[x].count - 1{
        let tallestTreeToTheLeft = forest[x][0..<y].max()!
        let tallestTreeToRight = forest[x][y+1..<forest[y].count].max()!
        let tallestTreeAbove = rotatedForest[y][0..<x].max()!
        let tallestTreeBelow = rotatedForest[y][x+1..<rotatedForest[y].count].max()!
        let currentTree = forest[x][y]
        
        if (currentTree > [tallestTreeToTheLeft, tallestTreeToRight].min()!) || (currentTree > [tallestTreeAbove, tallestTreeBelow].min()!) {
          forest[x][y].isVisisbleFromAnEdge = true
        }
      }
    }
    return forest
      .reduce([], +)
      .reduce(0) { $0 + ($1.isVisisbleFromAnEdge ? 1 : 0)}
  }
  
  func problem2(forest: Forest) -> Int {
    
    let rotatedForest = rotate(forest: forest)
    for x in 1..<forest.count - 1{
      for y in 1..<forest[x].count - 1{
        let leftTrees = Array(forest[x][0..<y].reversed())
        let rightTrees = Array(forest[x][y+1..<forest[y].count])
        let aboveTrees = Array(rotatedForest[y][0..<x].reversed())
        let belowTrees = Array(rotatedForest[y][x+1..<rotatedForest[y].count])
      
        let currentTree = forest[x][y]
       
        var leftViewingDistance = 1
        
        for i in 0..<leftTrees.count - 1 {
          if leftTrees[i].height >= currentTree.height  { break }
          leftViewingDistance += 1
        }

        var rightViewingDistance = 1
        for i in 0..<rightTrees.count - 1 {
          if rightTrees[i].height >= currentTree.height { break }
          rightViewingDistance += 1
        }

        var topViewingDistance = 1
        for i in 0..<aboveTrees.count - 1 {
          if aboveTrees[i].height >= currentTree.height { break }
          topViewingDistance += 1
        }
          
        var belowViewingDistance = 1
        for i in 0..<belowTrees.count - 1 {
          if belowTrees[i].height >= currentTree.height { break }
          belowViewingDistance += 1
        }
        currentTree.scenicScore = leftViewingDistance * rightViewingDistance * topViewingDistance * belowViewingDistance
      }
    }
    return forest
      .reduce([], +).max(by: {$0.scenicScore < $1.scenicScore})!.scenicScore
  }
  public static func main() {
    let day8 = Day_08()
    let forest = day8.parse(fileName: "input.txt")
    print(day8.problem1(forest: forest))
    print(day8.problem2(forest: forest))
  }
}
