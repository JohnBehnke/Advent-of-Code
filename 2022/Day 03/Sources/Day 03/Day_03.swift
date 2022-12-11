import Algorithms
import Foundation

@main
public struct Day_03 {
    static func readFile(fileName: String) -> [String]{
      let pathToFile = FileManager.default.currentDirectoryPath + "/"
      let content = try! String(contentsOfFile: pathToFile + fileName, encoding: .utf8)
      return Array(content.split(separator: "\n").map{String($0)})
    }
    
    static let alphabet = Array("_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
    
    static func problem1(rucksacks: [String]) -> Int {
      var sum = 0
      for rucksack in rucksacks {
        let l = rucksack[..<rucksack.index(rucksack.startIndex, offsetBy: rucksack.count / 2)]
        let r = rucksack[rucksack.index(rucksack.endIndex, offsetBy: rucksack.count / 2 * -1)...]
        let common = Set(l).intersection(Set(r)).first!
        sum += alphabet.firstIndex(of: common)!
      }
      return sum
    }
    
    static func problem2(rucksacks: [String]) -> Int {
      var sum = 0
      for collection in rucksacks.chunks(ofCount: 3).map({ Array($0) }) {
        let one = Set(collection[0])
        let two = Set(collection[1])
        let three = Set(collection[2])
        let common = one.intersection(two).intersection(three).first!
        
        sum += alphabet.firstIndex(of: common)!
      }
      return sum
    }

    public static func main() {
      let input = readFile(fileName: "input.txt")
      print(problem1(rucksacks: input))
      print(problem2(rucksacks: input))
    }
}
