import Foundation

struct Instruction {
  var numBlocks: Int
  var from: Int
  var to: Int
}

typealias Stacks = [Int: [Character]]

@main
public struct Day_05 {
  static func readFile(fileName: String) -> (Stacks, [Instruction]){
    let pathToFile = FileManager.default.currentDirectoryPath + "/"
    let content = try! String(contentsOfFile: pathToFile + fileName, encoding: .utf8)
    var stacks: Stacks = [:]
    var instructions: [Instruction] = []
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
        var parsedInstructionLine = String(line)
          .replacingOccurrences(of: "move ", with: "")
          .replacingOccurrences(of: " from ", with: ",")
          .replacingOccurrences(of: " to ", with: ",")
          .split(separator: ",")
        let newInstruction = Instruction(
          numBlocks: Int(parsedInstructionLine.removeFirst())!,
          from: Int(parsedInstructionLine.removeFirst())!,
          to: Int(parsedInstructionLine.removeFirst())!
        )
        instructions.append(newInstruction)
      }
    }
    for key in stacks.keys {
      stacks[key]!.reverse()
    }
    return (stacks, instructions)

  }
  
  
  static func problem1(stacks: [Int: [Character]], instructions: [Instruction]) -> String{
    var localStacks = stacks

    for instruction in instructions {
      for _ in 0..<instruction.numBlocks {
        localStacks[instruction.to]!.append(localStacks[instruction.from]!.removeLast())
      }
    }
   
    var returnString = ""
    for i in 1...localStacks.keys.count {
      returnString += String(localStacks[i]!.removeLast())
    }
    return returnString
  }
  
  static func problem2(stacks: Stacks, instructions: [Instruction]) -> String{
    var localStacks = stacks
    
    for instruction in instructions {
      var blocksToMove: [Character] = []
      for _ in 0..<instruction.numBlocks {
        blocksToMove.append(localStacks[instruction.from]!.removeLast())
      }
      localStacks[instruction.to]!.append(contentsOf: blocksToMove.reversed())
    }
    
    var returnString = ""
    for i in 1...localStacks.keys.count {
      returnString += String(localStacks[i]!.removeLast())
    }
    return returnString
  }
  
  public static func main() {
    let state = readFile(fileName: "input.txt")
    print(problem1(stacks: state.0, instructions: state.1))
    print(problem2(stacks: state.0, instructions: state.1))
  }
}
