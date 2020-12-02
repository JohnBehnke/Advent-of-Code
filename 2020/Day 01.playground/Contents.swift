import Cocoa

func readFile(fileName:String, fileExtension:String) -> [Int]{
  
  if let filePath = Bundle.main.path(forResource: fileName, ofType: fileExtension){
    do {
      let raw_content = try String(contentsOfFile: filePath, encoding: .utf8)
      let content = raw_content.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
      var input: [Int]  = []
      for line in content.split(separator: "\n") {
        input.append(Int(line) ?? 0)
      }
      return input
    } catch  {
      fatalError("Cannot read input file")
    }
  }
  fatalError("Input file not found")
}

func problem1(input: [Int]) -> Int {
  let numberSet = Set(input)
  for number in input {
    if numberSet.contains(2020 - number) {
      return (2020 - number) * number
    }
  }
  return -1
}

func problem2(input: [Int]) -> Int {
  let numberSet = Set(input)
  for number1 in input {
    for number2 in input {
      if numberSet.contains(2020 - (number1 + number2 )) {
        return (2020 - (number1 + number2 )) * number1 * number2
      }
    }
    
  }
  return -1
}

let parsedInput: [Int] = readFile(fileName: "input", fileExtension: "txt")
print(problem1(input: parsedInput))
print(problem2(input: parsedInput))

