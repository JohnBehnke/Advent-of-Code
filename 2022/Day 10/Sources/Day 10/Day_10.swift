import Foundation

typealias Program = [Instruction]
enum OpCode {
  case addx
  case noop
}

struct Instruction {
  let opcode: OpCode
  let operand: Int
  
  init(opcode: OpCode, operand: Int = 0) {
    self.opcode = opcode
    self.operand = operand
  }
}


@main
public struct Day_10 {
  
  static func parse(fileName: String) -> Program {
    let pathToFile = FileManager.default.currentDirectoryPath + "/"
    let content = try! String(contentsOfFile: pathToFile + fileName, encoding: .utf8)
    let lines = content.split(separator: "\n")
    return lines.map { $0.contains("noop") ? Instruction(opcode: .noop) : Instruction(opcode: .addx, operand: Int($0.split(separator: " ").last!)!) }
  }
  
  static func problem1(program: Program) -> Int {
    var inMemoryProgram = program
    var register = 1
    var cycle = 1
    var checkpoint = 20
    var signalStrengths: [Int] = []
    var nextActionCycle = 0
    var isExecutingInstruction = false
    var executingInstruction: Instruction?
    while !inMemoryProgram.isEmpty {
      
      if !isExecutingInstruction {
        var newInstruction = inMemoryProgram.removeFirst()
        
        if newInstruction.opcode == .addx {
          executingInstruction = newInstruction
          nextActionCycle = cycle + 1
          isExecutingInstruction = true
        }
      }
      
      if cycle == checkpoint && checkpoint <= 220 {
        print("\(checkpoint) \(register)")
        signalStrengths.append(register * checkpoint)
        checkpoint += 40
      }
      
      if isExecutingInstruction && cycle == nextActionCycle {
        isExecutingInstruction = false
        register += executingInstruction!.operand
        executingInstruction = nil
        nextActionCycle = 0
      }
      cycle += 1
    }
    print(signalStrengths)
    return signalStrengths.reduce(0,+)
  }
  static func problem2(program: Program) {
    var inMemoryProgram = program
    var register = 1
    var cycle = 1
    var nextActionCycle = 0
    var isExecutingInstruction = false
    var executingInstruction: Instruction?
    var screen: [[String]] = []
    var buffer: [String] = Array(repeating: " ", count: 40)
    var pixelPosition = 0
    while !inMemoryProgram.isEmpty {
      
      if !isExecutingInstruction {
        var newInstruction = inMemoryProgram.removeFirst()
        
        if newInstruction.opcode == .addx {
          executingInstruction = newInstruction
          nextActionCycle = cycle + 1
          isExecutingInstruction = true
        }
      }
      
      
      if pixelPosition >= register - 1 && pixelPosition <= register + 1 {
        buffer[pixelPosition] = "█"
      }
      if isExecutingInstruction && cycle == nextActionCycle {
        isExecutingInstruction = false
        register += executingInstruction!.operand
        executingInstruction = nil
        nextActionCycle = 0
      }
      
      cycle += 1
      pixelPosition += 1
      
      if pixelPosition == 40 {
        screen.append(buffer)
        buffer = Array(repeating: " ", count: 40)
        pixelPosition = 0
      }
    }
    for row in screen {
      print(row.joined())
    }
    
  }
  public static func main() {
    let program = parse(fileName: "input.txt")
    print(problem1(program: program))
    problem2(program: program)
  }
}
