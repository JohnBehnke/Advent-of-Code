import Foundation


func readFile(fileName:String, fileExtension:String) -> [[Int]]{
  
  if let filePath = Bundle.main.path(forResource: fileName, ofType: fileExtension){
    do {
      let raw_content = try String(contentsOfFile: filePath, encoding: .utf8)
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
      return allCalorieCounts
    } catch  {
      fatalError("Cannot read input file")
    }
  }
  fatalError("Input file not found")
}

func problem1(input: [[Int]]) -> Int {
  
  let result = input.map {$0.reduce(0) {$0 + $1}}.max()
  return result ?? 0
}

func problem2(input: [[Int]]) -> Int {
  
  let result = input.map {$0.reduce(0) {$0 + $1}}.sorted()
  return result.reversed()[0..<3].reduce(0){$0 + $1}
}

let parsedInput = readFile(fileName: "input", fileExtension: "txt")

let answer1 = problem1(input: parsedInput)
let answer2 = problem2(input: parsedInput)
