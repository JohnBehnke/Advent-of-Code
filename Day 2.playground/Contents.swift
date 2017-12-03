//: Playground - noun: a place where people can play

import Cocoa

extension String{
    subscript(index: Int) -> Character{
        return self[(self.index((self.startIndex), offsetBy: index))]
    }
}

func readFile(fileName:String, fileExtension:String) -> String{
    if let filePath = Bundle.main.path(forResource: fileName, ofType: fileExtension){
        do {
            let raw_content = try String(contentsOfFile: filePath, encoding: .utf8)
            return raw_content
        } catch  {
            fatalError("Cannot read input file")
        }
    }
    fatalError("Input file not found")
}



func transformInput(input: String) -> [[Int]]{
    let splitValues = inputFile.split(separator: "\n")
    var finalValues:[[String]] = Array()
    
    for line in splitValues {
        let cleaned = line.replacingOccurrences(of: "    ", with: ",").components(separatedBy: ",")
        finalValues.append(cleaned)
    }
    
    return finalValues.map { $0.map({ Int($0)!})}
}
func partOne(input: String) -> Int{
    let numberArray = transformInput(input: input)
    var checksum:Int = 0
    for row in numberArray {
        checksum += row.max()! - row.min()!
    }
    return checksum
}

func partTwo(input: String) -> Int{
    let numberArray = transformInput(input: input)
    var checksum:Int = 0
    //Not a fan of this... but theres not perm or combo for me to use...
    for row in numberArray {
        for x in row{
            for y in row{
                if x % y == 0 && x != y {
                    checksum += x / y
                    break
                }
            }
        }
    }
    return checksum
}

let inputFile: String = readFile(fileName: "input", fileExtension: "txt")

print(partOne(input: inputFile))
print(partTwo(input: inputFile))
