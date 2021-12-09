import Foundation

let path = Bundle.main.path(forResource: "input", ofType: "txt")
let fileContent = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)

let rows = fileContent.components(separatedBy: "\n").map { String($0) }

var heightmap = [String:Int]()

var basinsSums = [Int]()

let numberOfRows = rows.count
let numberOfColumns = Array(rows[0]).count

var basinPoints = [String]()

for rowIndex in 0..<(numberOfRows) {
    
    let columns = Array(rows[rowIndex]).map { String($0) }
    
    for columnIndex in 0..<(numberOfColumns) {
        
        heightmap["\(rowIndex):\(columnIndex)"] = Int(columns[columnIndex])!
    }
}

var solution = 0

var lowPoints = [String]()

for rowNumber in 0..<(numberOfRows) {
    
    for columnNumber in 0..<(numberOfColumns) {
        
        if heightmap["\(rowNumber + 1):\(columnNumber)"] != nil &&
            heightmap["\(rowNumber + 1):\(columnNumber)"]! <= heightmap["\(rowNumber):\(columnNumber)"]! {
            
            continue
        }
        
        if heightmap["\(rowNumber - 1):\(columnNumber)"] != nil &&
            heightmap["\(rowNumber - 1):\(columnNumber)"]! <= heightmap["\(rowNumber):\(columnNumber)"]! {
            
            continue
        }
        
        if heightmap["\(rowNumber):\(columnNumber + 1)"] != nil &&
            heightmap["\(rowNumber):\(columnNumber + 1)"]! <= heightmap["\(rowNumber):\(columnNumber)"]! {
            
            continue
        }
        
        if heightmap["\(rowNumber):\(columnNumber - 1)"] != nil &&
            heightmap["\(rowNumber):\(columnNumber - 1)"]! <= heightmap["\(rowNumber):\(columnNumber)"]! {
            
            continue
        }
        
        lowPoints.append("\(rowNumber):\(columnNumber)")
        
    }
}

func AddBasinCoordinates(_ currentPointX: Int, _ currentPointY: Int) -> Void {
    
    if basinPoints.contains("\(currentPointX):\(currentPointY)") {
        return;
    }
    
    if heightmap["\(currentPointX):\(currentPointY)"]! == 9 {
        return;
    }
    
    basinPoints.append("\(currentPointX):\(currentPointY)")
    
    if heightmap["\(currentPointX + 1):\(currentPointY)"] != nil &&
        heightmap["\(currentPointX + 1):\(currentPointY)"]! > heightmap["\(currentPointX):\(currentPointY)"]! {
        
        AddBasinCoordinates(currentPointX + 1, currentPointY)
    }
    
    if heightmap["\(currentPointX - 1):\(currentPointY)"] != nil &&
        heightmap["\(currentPointX - 1):\(currentPointY)"]! > heightmap["\(currentPointX):\(currentPointY)"]! {
        
        AddBasinCoordinates(currentPointX - 1, currentPointY)
    }
    
    if heightmap["\(currentPointX):\(currentPointY + 1)"] != nil &&
        heightmap["\(currentPointX):\(currentPointY + 1)"]! > heightmap["\(currentPointX):\(currentPointY)"]! {
        
        AddBasinCoordinates(currentPointX, currentPointY + 1)
    }
    
    if heightmap["\(currentPointX):\(currentPointY - 1)"] != nil &&
        heightmap["\(currentPointX):\(currentPointY - 1)"]! > heightmap["\(currentPointX):\(currentPointY)"]! {
        
        AddBasinCoordinates(currentPointX, currentPointY - 1)
    }
    
}

for lowPoint in lowPoints {
    
    basinPoints = [String]()
    
    let coordinates = lowPoint.components(separatedBy: ":")
    
    let row = Int(coordinates[0])!
    let column = Int(coordinates[1])!
    
    AddBasinCoordinates(row, column)
    
    basinsSums.append(basinPoints.count)
    
}

let largestBasinsSums = basinsSums.sorted(by: >).prefix(3)

solution = largestBasinsSums.reduce(1, *)

print(solution)
