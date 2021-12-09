import Foundation

let path = Bundle.main.path(forResource: "input", ofType: "txt")
let fileContent = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)

let rows = fileContent.components(separatedBy: "\n").map { String($0) }

var heightmap = [String:Int]()

let numberOfRows = rows.count
let numberOfColumns = Array(rows[0]).count

for rowIndex in 0..<(numberOfRows) {
    
    let columns = Array(rows[rowIndex]).map { String($0) }
    
    for columnIndex in 0..<(numberOfColumns) {
        
        heightmap["\(rowIndex):\(columnIndex)"] = Int(columns[columnIndex])!

    }
}

var solution = 0

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
        
        solution += (heightmap["\(rowNumber):\(columnNumber)"]! + 1)
    }
}

print(solution)
