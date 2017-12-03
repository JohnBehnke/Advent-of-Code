//: Playground - noun: a place where people can play

import Cocoa


func partOne(input:Int) -> Int{
    var targetSquare: Int = 1
    
    var counter: Int = 1
    
    while true {
        let squared = counter * counter
        if squared <  input {
            counter += 2
        } else{
            targetSquare = squared
            break
        }
    }
    
    var corners:[Int] = []
    for i in 0..<5{
        corners.append(targetSquare - (counter - 1) * i)
    }
    
    let middleVal = counter / 2
    var x = 0
    var y = 0
    
    var found = false
    var i = targetSquare - 1
    
    if !found {
        while i >= corners[1] {
            x += 1
            if i == input{
                found = true
                break
            }
            else{
                i -= 1
            }
        }
    }
    
    if !found {
        while i >= corners[2] {
            y += 1
            if i == input{
                found = true
                break
            }
            else{
                i -= 1
            }
        }
    }
    
    if !found {
        while i >= corners[3] {
            x -= 1
            if i == input{
                found = true
                break
            }
            else{
                i -= 1
            }
        }
    }
    
    if !found {
        while i >= corners[4]  {
            y -= 1
            if i == input{
                found = true
                break
            }
            else{
                i -= 1
            }
        }
    }
    let distance = abs(x - middleVal) + abs(y -  middleVal)
    return distance
}


func partTwo(input:Int) -> Int{
    let possibleNeighborOffsets = [(1, 0), (1, -1), (0, -1), (-1, -1), (-1, 0), (-1, 1), (0, 1), (1, 1)]
    
    var x = 0
    var y = 0
    var dx = 0
    var dy = -1
    
    
    var grid:[String: Int] = [:] //Hacky since tuples aren't hashable in Swift (easily)
    while true{
        var total = 0
        //Look at the possible neighors, and if they exist, add their values to the total
        for n in possibleNeighborOffsets{
            let x1 = n.0
            let y1 = n.1
            
            if grid["(\(x + x1),\(y + y1))"] != nil {
                total += grid["(\(x + x1),\(y + y1))"]!
            }
        }
        if total > input {
            return total
        }
        if (x,y) == (0,0){
            grid["(0,0)"] = 1
        }
        else{
            grid["(\(x),\(y))"] = total
        }
        if (x == y) || (x < 0 && x == -y) || (x > 0 && x == 1-y) {
            let temp = -dy
            let temp2 = dx
            dx = temp
            dy = temp2
        }
        x = x + dx
        y =  y + dy
    }
}
print(partOne(input: 325489))
print(partTwo(input: 325489))
