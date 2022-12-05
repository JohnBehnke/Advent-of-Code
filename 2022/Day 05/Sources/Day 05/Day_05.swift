import Foundation



@main
public struct Day_05 {
  func readFile(fileName: String) -> ([Int: [Character]], [(Int, Int, Int)]){
    let pathToFile = FileManager.default.currentDirectoryPath + "/"
    let content = try! String(contentsOfFile: pathToFile + fileName, encoding: .utf8)
    var stacks: [Int: [Character]] = [:]
    var moves: [(Int, Int, Int)] = []
    for line in content.split(separator: "\n") {
   
    
      if line.contains("[") {
        var count = 0
        var currentBox = 0
        for char in line {
          if char.isLetter {
            if stacks[currentBox] == nil {
              stacks[currentBox] = [char]
            } else {
              stacks[currentBox ]?.append(char)
          
            }
          }
          if count % 4 == 0 {
            currentBox += 1
          }
          count += 1
        }
      
      } else if line.contains("move") {
        var line2 = String(line).replacingOccurrences(of: "move ", with: "").replacingOccurrences(of: " from ", with: ",").replacingOccurrences(of: " to ", with: ",").split(separator: ",")
        
        let foo = (Int(line2.removeFirst())!, Int(line2.removeFirst())!, Int(line2.removeFirst())!)
        moves.append(foo)
      }
    }
    for key in stacks.keys {
      stacks[key]!.reverse()
    }
    return (stacks, moves)

  }
  
  
  func problem1(stacks: [Int: [Character]], moves: [(Int, Int, Int)]) -> String{
    var localStacks = stacks

    for move in moves {
      for _ in 0..<move.0 {
        localStacks[move.2]!.append(localStacks[move.1]!.removeLast())
        
      }
    }
   
    var ret = ""
    for i in 1...localStacks.keys.count {
      ret += String(localStacks[i]!.removeLast())
    }
    return ret
  }
  
  func problem2(stacks: [Int: [Character]], moves: [(Int, Int, Int)]) -> String{
    var localStacks = stacks
    
    for move in moves {
      var temp: [Character] = []
      for _ in 0..<move.0 {
        temp.append(localStacks[move.1]!.removeLast())
      }
      localStacks[move.2]!.append(contentsOf: temp.reversed())
    }
    
    var ret = ""
    for i in 1...localStacks.keys.count {
      ret += String(localStacks[i]!.removeLast())
    }
    return ret
  }
  
  public static func main() {
    let day5 = Day_05()
    let state = day5.readFile(fileName: "input.txt")
    print(day5.problem1(stacks: state.0, moves: state.1))
    print(day5.problem2(stacks: state.0, moves: state.1))
  }
}
