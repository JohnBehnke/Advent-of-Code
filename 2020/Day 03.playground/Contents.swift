import Cocoa

func readFile(fileName:String, fileExtension:String) -> [[Character]]{
  
  if let filePath = Bundle.main.path(forResource: fileName, ofType: fileExtension){
    do {
      let raw_content = try String(contentsOfFile: filePath, encoding: .utf8)
      let content = raw_content.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
      var input: [[Character]]  = []
      for line in content.split(separator: "\n") {
        input.append(Array(line))
      }
      return input
    } catch  {
      fatalError("Cannot read input file")
    }
  }
  fatalError("Input file not found")
}

func problem1(input: [[Character]]) -> Int {
  var numberTrees = 0
  
  var x = 0
  var y = 0
  
  while x < input.count {
    
    if y >= input[0].count {
      
      y -= input[0].count
    }
    if input[x][y] == "#" {
      numberTrees += 1
    }
    
    y += 3
    x += 1
  }
  return numberTrees
}

func problem2(input: [[Character]]) -> Int {
  var numberTrees = 0
  
  
  
  let slopes = [[1,1], [1,3], [1,5], [1,7], [2,1]]
  
  for slope in slopes {
    var localTrees = 0
    var x = 0
    var y = 0
    while x < input.count {
      
      if y >= input[0].count {
        
        y -= input[0].count
      }
      if input[x][y] == "#" {
        localTrees += 1
      }
      
      y += slope[1]
      x += slope[0]
    }
    if numberTrees == 0 {
      numberTrees = localTrees
    } else {
      numberTrees *= localTrees
    }
  }
  
  return numberTrees
}

let input = readFile(fileName: "input", fileExtension: "txt")
print(problem1(input: input))
print(problem2(input: input))
