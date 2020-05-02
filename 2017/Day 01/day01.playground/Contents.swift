// --- Day 1: Inverse Captcha ---

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
            let content = raw_content.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            return content
        } catch  {
            fatalError("Cannot read input file")
        }
    }
    fatalError("Input file not found")
}

func partOne(content: String) -> Int{
    var totalSum: Int = 0
    for (index, digit) in (content.enumerated()) {
        if index == (content.count) - 1 {
            if digit == content[0]{
                totalSum += Int(String(digit))!
            }
        }
        else if digit == content[index + 1] {
            totalSum += Int(String(digit))!
        }
    }

    return totalSum
}

func partTwo(content: String) -> Int{
    
    let circularString: String = content + content
    let offSet: Int = content.count / 2
    var totalSum = 0
    for (index, digit) in content.enumerated(){
        if digit == circularString[index + offSet] {
            totalSum += Int(String(digit))!
        }
        
    }
    
    return totalSum
}
let content:String = readFile(fileName: "input", fileExtension: "txt")
print(partOne(content: content))
print(partTwo(content: content))
