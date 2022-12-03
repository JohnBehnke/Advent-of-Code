import Foundation

extension Array {
  func chunked(into size: Int) -> [[Element]] {
      return stride(from: 0, to: count, by: size).map {
          Array(self[$0 ..< Swift.min($0 + size, count)])
      }
  }
}

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
  for collection in rucksacks.chunked(into: 3) {
    let one = Set(collection[0])
    let two = Set(collection[1])
    let three = Set(collection[2])
    let common = one.intersection(two).intersection(three).first!
    
    sum += alphabet.firstIndex(of: common)!
  }
  return sum
}
let input = readFile(fileName: CommandLine.arguments[1])
print(problem1(rucksacks: input))
print(problem2(rucksacks: input))
