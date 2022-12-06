import Foundation
@main
public struct Day_06 {
  func readFile(fileName: String) -> [Character] {
    let pathToFile = FileManager.default.currentDirectoryPath + "/"
    let content = try! String(contentsOfFile: pathToFile + fileName, encoding: .utf8)
    return Array(content)
  }
  func problem1(input: [Character]) -> Int {
    var index = 0
    for _ in 0..<input.count - 4 {
      if Set(input[index..<index+4]).count == 4 { return index + 4 }
      index += 1
    }
    return -1
  }
  func problem2(input: [Character]) -> Int {
    var index = 0
    for _ in 0..<input.count - 14 {
      if Set(input[index..<index+14]).count == 14 { 
        return index + 14
      }   
      index += 1
    }
    return index
  }
  public static func main() {
    let day6 = Day_06()
    let input = day6.readFile(fileName: "input.txt")
    print(day6.problem1(input: input))
    print(day6.problem2(input: input))
  }
}
