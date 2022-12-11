import Foundation

enum Operator {
  case add
  case multiply
  init(_ string: String) {
    switch string {
      case "+":
        self = .add
      case "*":
        self = .multiply
      default:
        self = .add
    }
  }
}

struct Operation {
  var op: Operator
  var operand: String
}

struct Monkey {
  var items: [Int]
  var operation: Operation
  var testCondition: Int
  var trueTarget: Int
  var falseTarget: Int
  var itemsInspected: Int = 0
  
  init(items: [Int], operation: Operation, testCondition: Int, trueTarget: Int, falseTarget: Int) {
    self.items = items
    self.operation = operation
    self.testCondition = testCondition
    self.trueTarget = trueTarget
    self.falseTarget = falseTarget
  }
  
  mutating func dumpAllHeldItems() {
    itemsInspected += items.count
    items.removeAll()
  }
}

@main
public struct Day_11 {
  
  static func parse(fileName: String) -> [Monkey] {
    let pathToFile = FileManager.default.currentDirectoryPath + "/"
    let content = try! String(contentsOfFile: pathToFile + fileName, encoding: .utf8)
    var monkies: [Monkey] = []
    let lines = content.split(separator: "\n", omittingEmptySubsequences: false)
    
    var formattedLines: [[String]] = []
    var workingLine: [String] = []
    for line in lines {
      if line == "" {
        formattedLines.append(workingLine)
        workingLine.removeAll()
        continue
      }
      workingLine.append(String(line.trimmingCharacters(in: .whitespaces)))
      
    }
    
    for line in formattedLines {
      
      let startingItems = line[1].split(separator: ":")[1].split(separator: ",").map {Int($0.trimmingCharacters(in: .whitespaces))!}
      let rawOperation = String(line[2].split(separator: "=")[1]).trimmingCharacters(in: .whitespaces)
      let operation = Operation(op: rawOperation.contains("+") ? .add : .multiply, operand: String((rawOperation.contains("+") ? rawOperation.split(separator: "+") :  rawOperation.split(separator: "*"))[1].trimmingCharacters(in: .whitespaces)))
      let testCondition = Int(line[3].split(separator: " ").last!)!
      let trueMonkey = Int(line[4].split(separator: " ").last!)!
      let falseMonkey = Int(line[5].split(separator: " ").last!)!
      monkies.append(Monkey(items: startingItems, operation: operation, testCondition: testCondition, trueTarget: trueMonkey, falseTarget: falseMonkey))
    }
    return monkies
  }
  
  static func problem1(monkies: [Monkey]) -> Int {
    var workingMonkies = monkies
    var round = 0
    while round < 20 {
      for i in 0..<workingMonkies.count {
        for item in workingMonkies[i].items {
          let workingMonkey = workingMonkies[i]
          var itemToInspect = item
          let operand =  workingMonkey.operation.operand == "old" ? itemToInspect : Int( workingMonkey.operation.operand)!
          switch  workingMonkey.operation.op {
            case .add:
              itemToInspect += operand
            case .multiply:
              itemToInspect *= operand
          }
          itemToInspect /= 3
          
          if itemToInspect.isMultiple(of:  workingMonkey.testCondition) {
            workingMonkies[ workingMonkey.trueTarget].items.append(itemToInspect)
          } else {
            workingMonkies[ workingMonkey.falseTarget].items.append(itemToInspect)
          }
        }
        workingMonkies[i].dumpAllHeldItems()
      }
      round += 1
    }
    return workingMonkies.map { $0.itemsInspected }.sorted().reversed()[0...1].reduce(1, *)
  }
  
  static func problem2(monkies: [Monkey]) -> Int {
    var workingMonkies = monkies
    var round = 0
    let worryDivisor = workingMonkies.map {$0.testCondition}.reduce(1,*)
    while round < 10_000 {
      for i in 0..<workingMonkies.count {
        for item in workingMonkies[i].items {
          let workingMonkey = workingMonkies[i]
          var itemToInspect = item
          let operand =  workingMonkey.operation.operand == "old" ? itemToInspect : Int( workingMonkey.operation.operand)!
          switch  workingMonkey.operation.op {
            case .add:
              itemToInspect += operand
            case .multiply:
              itemToInspect *= operand
          }
          itemToInspect %= worryDivisor
          
          if itemToInspect.isMultiple(of:  workingMonkey.testCondition) {
            workingMonkies[ workingMonkey.trueTarget].items.append(itemToInspect)
          } else {
            workingMonkies[ workingMonkey.falseTarget].items.append(itemToInspect)
          }
        }
        workingMonkies[i].dumpAllHeldItems()
      }
      round += 1
    }
    return workingMonkies.map { $0.itemsInspected }.sorted().reversed()[0...1].reduce(1, *)
  }
  public static func main() {
    let monkies = parse(fileName: "input.txt")
    print(problem1(monkies: monkies))
    print(problem2(monkies: monkies))
  }
}
