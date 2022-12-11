import Foundation
@main
public struct Day_06 {
  static func readFile(fileName: String) -> [Character] {
    let pathToFile = FileManager.default.currentDirectoryPath + "/"
    let content = try! String(contentsOfFile: pathToFile + fileName, encoding: .utf8)
    return Array(content)
  }
  static func problem1(input: [Character]) -> Int {
    var index = 0
    for _ in 0..<input.count - 4 {
      if Set(input[index..<index+4]).count == 4 { return index + 4 }
      index += 1
    }
    return -1
  }
  static func problem2(input: [Character]) -> Int {
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
    let input = readFile(fileName: "input.txt")
    print(problem1(input: input))
    print(problem2(input: input))
  }
}
