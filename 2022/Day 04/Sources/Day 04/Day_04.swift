import Foundation
@main
public struct Day_04 {
    static func readFile(fileName: String) -> [(String, String)]{
      let pathToFile = FileManager.default.currentDirectoryPath + "/"
      let content = try! String(contentsOfFile: pathToFile + fileName, encoding: .utf8)
      var assignments: [(String, String)] = []
      for line in content.split(separator: "\n") {
          let splitLine = line.split(separator: ",")
        assignments.append((String(splitLine.first!), String(splitLine.last!)))
      }
      return assignments
    }
    
    
    static func problem1(assignments: [(String, String)]) -> Int {
      var sum = 0
      for assignment in assignments {
        let split1Line = assignment.0.split(separator: "-")
        let lower1Bound = Int(split1Line.first!)!
        let upper1Bound = Int(split1Line.last!)!
        let assignment1Set = Set(lower1Bound...upper1Bound)
        let split2Line = assignment.1.split(separator: "-")
        let lower2Bound = Int(split2Line.first!)!
        let upper2Bound = Int(split2Line.last!)!
        let assignment2Set: Set<Int> = Set(lower2Bound...upper2Bound)
        if assignment2Set.isSubset(of: assignment1Set) || assignment1Set.isSubset(of: assignment2Set) { sum += 1}
      }
      return sum
    }
    
    static func problem2(assignments: [(String, String)]) -> Int {
      var sum = 0
      for assignment in assignments {
        let split1Line = assignment.0.split(separator: "-")
        let lower1Bound = Int(split1Line.first!)!
        let upper1Bound = Int(split1Line.last!)!
        let assignment1Set = Set(lower1Bound...upper1Bound)
        let split2Line = assignment.1.split(separator: "-")
        let lower2Bound = Int(split2Line.first!)!
        let upper2Bound = Int(split2Line.last!)!
        let assignment2Set: Set<Int> = Set(lower2Bound...upper2Bound)
        if assignment2Set.intersection(assignment1Set).count > 0 { sum += 1}
      }
      return sum
    }

    public static func main() {
      let input = readFile(fileName: "input.txt")
      print(problem1(assignments: input))
      print(problem2(assignments: input))
    }
}
