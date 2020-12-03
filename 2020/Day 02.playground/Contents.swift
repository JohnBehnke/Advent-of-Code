import Cocoa

extension String{
    subscript(index: Int) -> Character{
        return self[(self.index((self.startIndex), offsetBy: index))]
    }
}

func readFile(fileName:String, fileExtension:String) -> [String]{
  
  if let filePath = Bundle.main.path(forResource: fileName, ofType: fileExtension){
    do {
      let raw_content = try String(contentsOfFile: filePath, encoding: .utf8)
      let content = raw_content.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
      var input: [String]  = []
      for line in content.split(separator: "\n") {
        input.append(String(line))
      }
      return input
    } catch  {
      fatalError("Cannot read input file")
    }
  }
  fatalError("Input file not found")
}

func problem1(input: [String]) -> Int {
  var validPasswordCount = 0
  for line in input {
    let split1 = line.split(separator: ":")
    let password = split1[1].trimmingCharacters(in: .whitespaces)
    let split2 = split1[0].split(separator: " ")
    let enforcedCharacter = split2[1]
    let split3 = split2[0].split(separator: "-")
    let lowerbound = Int(split3[0]) ?? Int.min
    let upperbound = Int(split3[1]) ?? Int.max
    
    let enforcedCharacterCount = password.components(separatedBy: enforcedCharacter).count - 1
    if enforcedCharacterCount >= lowerbound && enforcedCharacterCount <= upperbound {
      validPasswordCount += 1
    }
    
  }
  
  return validPasswordCount
}
func problem2(input: [String]) -> Int {
  var validPasswordCount = 0
  for line in input {
    let split1 = line.split(separator: ":")
    let password = split1[1].trimmingCharacters(in: .whitespaces)
    let split2 = split1[0].split(separator: " ")
    let enforcedCharacter = Character(String(split2[1]))
    let split3 = split2[0].split(separator: "-")
    let firstIndex = Int(split3[0]) ?? Int.min
    let secondIndex = Int(split3[1]) ?? Int.max
    
    if (password[firstIndex - 1] == enforcedCharacter) != (password[secondIndex - 1] == enforcedCharacter) {
      validPasswordCount += 1
    }
    
  }
  
  return validPasswordCount
}
let input = readFile(fileName: "input", fileExtension: "txt")
print(problem1(input: input))
print(problem2(input: input))
