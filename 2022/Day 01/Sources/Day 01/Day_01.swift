import Foundation

@main
public struct Day_01 {
    func readFile(fileName:String) -> [[Int]]{
      
      let pathToFile = FileManager.default.currentDirectoryPath + "/"
       let raw_content = try! String(contentsOfFile: pathToFile + fileName, encoding: .utf8)
          let content = raw_content
          var allCalorieCounts: [[Int]] = []
          var individualCalorieCount: [Int]  = []
          for line in content.split(separator: "\n", omittingEmptySubsequences: false) {
            if line == "" {
              allCalorieCounts.append(individualCalorieCount)
              individualCalorieCount.removeAll()
            } else {
              individualCalorieCount.append(Int(line) ?? 0)
            }
           
          }
          allCalorieCounts.append(individualCalorieCount)
          individualCalorieCount.removeAll()
          return allCalorieCounts
    }
    
    func problem1(input: [[Int]]) -> Int {
      let result = input.map {$0.reduce(0) {$0 + $1}}.max()
      return result ?? 0
    }
    
    func problem2(input: [[Int]]) -> Int {
      let result = input.map {$0.reduce(0) {$0 + $1}}.sorted()
      return result.reversed()[0..<3].reduce(0){$0 + $1}
    }

    public static func main() {
      let day1 = Day_01()
       let result = day1.readFile(fileName: "input.txt")
       print(day1.problem1(input: result))
       print(day1.problem2(input: result))

    }
}
