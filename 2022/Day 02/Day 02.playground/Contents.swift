import Foundation


func moveToValue(move: String) -> Int {
  switch move {
    case "A","X":
      return 1
    case "B","Y":
      return 2
    case "C","Z":
      return 3
    default:
      return 0
  }
}

enum Outcome {
  case win, loss, draw
}

func playRound(playerMove: String, opponentMove: String) -> Outcome {
  
  if playerMove == "X" {
    if opponentMove == "A" {
      return .draw
    } else if opponentMove == "B" {
      return .loss
    } else {
      return .win
    }
  } else if playerMove == "Y" {
    if opponentMove == "A" {
      return .win
    } else if opponentMove == "B" {
      return .draw
    } else {
      return .loss
    }
  } else {
    if opponentMove == "A" {
      return .loss
    } else if opponentMove == "B" {
      return .win
    } else {
      return .draw
    }
  }
}

func readFile(fileName:String, fileExtension:String) -> [(String, String)]{
  
  if let filePath = Bundle.main.path(forResource: fileName, ofType: fileExtension){
    do {
      let raw_content = try String(contentsOfFile: filePath, encoding: .utf8)
      let content = raw_content
      var rounds: [(String, String)] = []
      for line in content.split(separator: "\n") {
        let picks = line.split(separator: " ")
        rounds.append((String(picks.first!), String(picks.last!)))
      }
      return rounds
    } catch  {
      fatalError("Cannot read input file")
    }
  }
  fatalError("Input file not found")
}

func problem1(rounds: [(String, String)]) -> Int {
  
  return rounds.reduce(0) { partialResult, round in
    let opponentMoveValue = moveToValue(move: round.0)
    let playerMoveValue = moveToValue(move: round.1)
    let outcome = playRound(playerMove: round.1, opponentMove: round.0)
    switch outcome {
      case .win:
        return partialResult + 6 + playerMoveValue
      case .loss:
        return partialResult + playerMoveValue
      case .draw:
        return partialResult + 3 + playerMoveValue
    }
   
  }
}

func problem2(rounds: [(String, String)]) -> Int {
  
  return rounds.reduce(0) { partialResult, round in
    let opponentMoveValue = moveToValue(move: round.0)
//    let playerMoveValue = moveToValue(move: round.1)
//    let outcome = playRound(playerMove: round.1, opponentMove: round.0)
    switch round.1 {
      case "X": //lose
        switch round.0 {
          case "A":
            return partialResult + 3
          case "B":
            return partialResult + 1
          case "C":
            return partialResult + 2
          default:
            return partialResult + 0
        }
      case "Y": //draw
        switch round.0 {
          case "A":
            return partialResult + 1 + 3
          case "B":
            return partialResult + 2 + 3
          case "C":
            return partialResult + 3 + 3
          default:
            return partialResult + 0
        }
      case "Z": //win
        switch round.0 {
          case "A":
            return partialResult + 2 + 6
          case "B":
            return partialResult + 3 + 6
          case "C":
            return partialResult + 1 + 6
          default:
            return partialResult + 0
        }
      default:
        return partialResult + 0
    }
    
  }
}
let result = readFile(fileName: "input", fileExtension: "txt")

print(problem1(rounds: result))
print(problem2(rounds: result))
