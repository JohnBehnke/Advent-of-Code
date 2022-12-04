import Algorithms
import Foundation

extension Array {
  func chunked(into size: Int) -> [[Element]] {
      return stride(from: 0, to: count, by: size).map {
          Array(self[$0 ..< Swift.min($0 + size, count)])
      }
  }
}


@main
public struct Day_03 {
    func readFile(fileName: String) -> [String]{
      let pathToFile = FileManager.default.currentDirectoryPath + "/"
      let content = try! String(contentsOfFile: pathToFile + fileName, encoding: .utf8)
      return Array(content.split(separator: "\n").map{String($0)})
    }
    
    let alphabet = Array("_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
    
    func problem1(rucksacks: [String]) -> Int {
      var sum = 0
      for rucksack in rucksacks {
        let l = rucksack[..<rucksack.index(rucksack.startIndex, offsetBy: rucksack.count / 2)]
        let r = rucksack[rucksack.index(rucksack.endIndex, offsetBy: rucksack.count / 2 * -1)...]
        let common = Set(l).intersection(Set(r)).first!
        sum += alphabet.firstIndex(of: common)!
      }
      return sum
    }
    
    func problem2(rucksacks: [String]) -> Int {
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
    let day3 = Day_03()
       let input = day3.readFile(fileName: "input.txt")
       print(day3.problem1(rucksacks: input))
       print(day3.problem2(rucksacks: input))
    }
}
