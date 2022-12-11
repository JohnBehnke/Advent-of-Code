import Foundation

struct File {
  var name: String
  var size: Int
  
  func print(depth: Int) {
    Swift.print("\(String(repeating: "  ", count: depth + 1)) - \(name) (file, size=\(size))")
  }
}

class Directory {
  var parent: Directory?
  var name: String
  var files: [File]
  var subDirectories: [Directory]
  var size: Int {
    let totalFileSize = files.reduce(0) { $0 + $1.size }
    let totalSubDirectorySize = subDirectories.reduce(0) { $0 + $1.size }
    return totalFileSize + totalSubDirectorySize
  }
  
  init(parent: Directory? = nil, name: String = "/", files: [File] = [], subDirectories: [Directory] = []) {
    self.parent = parent
    self.name = name
    self.files = files
    self.subDirectories = subDirectories
  }
  
  func print(depth: Int = 0) {
    Swift.print("\(String(repeating: "  ", count: depth)) - \(name) (dir, size=\(size))")
    for directory in subDirectories {
      directory.print(depth: depth + 1)
    }
    for file in files {
      file.print(depth: depth)
    }
  }
}


@main
public struct Day_07 {
  static func parse(fileName: String) -> Directory{
    let pathToFile = FileManager.default.currentDirectoryPath + "/"
    let content = try! String(contentsOfFile: pathToFile + fileName, encoding: .utf8)
    let lines = content.split(separator: "\n").map { String($0) }
    var currentWorkingDirectory = Directory()
    for line in lines {
      let splitLine = Array(line.split(separator: " "))
      if splitLine[0] == "$" {
        if splitLine[1] == "cd" {
          if splitLine[2] == ".." {
            if currentWorkingDirectory.parent != nil {
              currentWorkingDirectory = currentWorkingDirectory.parent!
            }
          } else if splitLine[2] == "/" {
            while currentWorkingDirectory.parent != nil {
              currentWorkingDirectory = currentWorkingDirectory.parent!
            }
          } else {
            if let index = currentWorkingDirectory.subDirectories.firstIndex(where: { $0.name == splitLine[2] }) {
              currentWorkingDirectory = currentWorkingDirectory.subDirectories[index]
            } else {
              let newDirectory = Directory(parent: currentWorkingDirectory, name: String(splitLine[2]))
              currentWorkingDirectory.subDirectories.append(newDirectory)
              currentWorkingDirectory = newDirectory
            }
          }
        }
      } else {
        if splitLine[0] == "dir" {
        } else {
          if currentWorkingDirectory.files.firstIndex(where: { $0.name == splitLine[1] }) == nil {
            currentWorkingDirectory.files.append(File(name: String(splitLine[1]), size: Int(splitLine[0])!))
          }
        }
      }
    }
    
    while currentWorkingDirectory.parent != nil {
      currentWorkingDirectory = currentWorkingDirectory.parent!
    }

    return currentWorkingDirectory
  }
  static func problem1(directory: Directory) -> Int {
    if directory.subDirectories.isEmpty {
      return directory.size <= 100000 ? directory.size : 0
    }
    return directory.subDirectories.reduce(0) { $0 +  problem1(directory: $1)}  +  (directory.size <= 100000 ? directory.size : 0)
  }
  
  static func problem2(directory: Directory, target: Int) -> Int {
    
    if directory.subDirectories.isEmpty {
      return directory.size
    }
    let largestSubdirectorySize = directory.subDirectories
      .map { problem2(directory: $0, target: target) }
      .filter { $0 >= target}
      .min() ?? Int.max
    return directory.size >= target ? directory.size < largestSubdirectorySize ? directory.size : largestSubdirectorySize : largestSubdirectorySize
  }
  
  public static func main() {
    let rootDirectory = parse(fileName: "input.txt")
    print(problem1(directory: rootDirectory))
    print(problem2(directory: rootDirectory, target: 30000000 - (70000000 - rootDirectory.size))) // 647391 40528671
  }
}
