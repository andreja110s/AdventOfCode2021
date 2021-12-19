import Foundation

let path = Bundle.main.path(forResource: "input", ofType: "txt")
let fileContent = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)

let lines = fileContent.components(separatedBy: "\n").map { String($0) }

var mapOfOctopi = [String:Int]()

var solution = 0

for rowIndex in 0..<(lines.count) {
    
    let columns = Array(lines[rowIndex]).map { Int(String($0))! }
    
    for columnIndex in 0..<(columns.count) {
    
        mapOfOctopi["\(rowIndex):\(columnIndex)"] = columns[columnIndex]
        
    }
}

func CheckAndFlash(_ x: Int, _ y: Int) -> Void {
    
    if mapOfOctopi["\(x):\(y)"] == nil {
        return
    }
    
    if mapOfOctopi["\(x):\(y)"]! < 10 {
        return
    }
    
    mapOfOctopi["\(x):\(y)"] = -1
    
    if mapOfOctopi["\(x + 1):\(y)"] != nil && mapOfOctopi["\(x + 1):\(y)"] != -1 {
        
        mapOfOctopi["\(x + 1):\(y)"]! += 1
        
    }
    if mapOfOctopi["\(x - 1):\(y)"] != nil && mapOfOctopi["\(x - 1):\(y)"] != -1 {
        
        mapOfOctopi["\(x - 1):\(y)"]! += 1
    }
    if mapOfOctopi["\(x):\(y + 1)"] != nil && mapOfOctopi["\(x):\(y + 1)"] != -1 {
        
        mapOfOctopi["\(x):\(y + 1)"]! += 1
    }
    if mapOfOctopi["\(x):\(y - 1)"] != nil && mapOfOctopi["\(x):\(y - 1)"] != -1 {
        
        mapOfOctopi["\(x):\(y - 1)"]! += 1
    }
    if mapOfOctopi["\(x + 1):\(y + 1)"] != nil && mapOfOctopi["\(x + 1):\(y + 1)"] != -1 {
        
        mapOfOctopi["\(x + 1):\(y + 1)"]! += 1
    }
    if mapOfOctopi["\(x - 1):\(y + 1)"] != nil && mapOfOctopi["\(x - 1):\(y + 1)"] != -1 {
        
        mapOfOctopi["\(x - 1):\(y + 1)"]! += 1
        
    }
    if mapOfOctopi["\(x + 1):\(y - 1)"] != nil && mapOfOctopi["\(x + 1):\(y - 1)"] != -1 {
        
        mapOfOctopi["\(x + 1):\(y - 1)"]! += 1
        
    }
    if mapOfOctopi["\(x - 1):\(y - 1)"] != nil && mapOfOctopi["\(x - 1):\(y - 1)"] != -1 {
        
        mapOfOctopi["\(x - 1):\(y - 1)"]! += 1
        
    }
    
    CheckAndFlash(x + 1, y)
    CheckAndFlash(x - 1, y)
    CheckAndFlash(x, y + 1)
    CheckAndFlash(x, y - 1)
    CheckAndFlash(x + 1, y + 1)
    CheckAndFlash(x + 1, y - 1)
    CheckAndFlash(x - 1, y + 1)
    CheckAndFlash(x - 1, y - 1)
    
}

while true {
    
    solution += 1

    for (coordinate, _) in mapOfOctopi {
        
        mapOfOctopi[coordinate]! += 1
    }
    
    for (coordinate, _) in mapOfOctopi {
        
        let octopusCoordinates = coordinate.components(separatedBy: ":").map { Int($0)! }
        
        CheckAndFlash(octopusCoordinates[0], octopusCoordinates[1])
    }
    
    var flashingOctopi = 0
    
    for (_, octopusEnergyValue) in mapOfOctopi {
        
        if octopusEnergyValue == -1 {
            flashingOctopi += 1
        }
        
    }
    
    if flashingOctopi == mapOfOctopi.count {
        break
    }
    
    for (coordinate, _) in mapOfOctopi {
        
        if mapOfOctopi[coordinate]! == -1 {
            mapOfOctopi[coordinate] = 0
        }
        
    }
}

print(solution)
