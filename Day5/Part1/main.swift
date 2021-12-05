import Foundation

let path = Bundle.main.path(forResource: "input", ofType: "txt")
let fileContent = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)

let lineDefinitions = fileContent.components(separatedBy: "\n").map { String($0) }

var board = [String:Int]()

for lineDefinition in lineDefinitions {
    
    let partsOfLine = lineDefinition.components(separatedBy: " -> ")
    
    let startPointDefinition = partsOfLine[0].components(separatedBy: ",").map { Int($0)! }
    let endPointDefinition = partsOfLine[1].components(separatedBy: ",").map { Int($0)! }
    
    let startPointX = startPointDefinition[0]
    let startPointY = startPointDefinition[1]
    
    let endPointX = endPointDefinition[0]
    let endPointY = endPointDefinition[1]
    
    if startPointX == endPointX {
        
        if (startPointY < endPointY) {
            
            for index in startPointY...endPointY {
                
                if board[String(startPointX) + ":" + String(index)] == nil {
                    board[String(startPointX) + ":" + String(index)] = 0
                }
                
                board[String(startPointX) + ":" + String(index)]! += 1
            }
        }
        else {
            for index in endPointY...startPointY {
                
                if board[String(startPointX) + ":" + String(index)] == nil {
                    board[String(startPointX) + ":" + String(index)] = 0
                }
                
                board[String(startPointX) + ":" + String(index)]! += 1
            }
        }
    }
    else if startPointY == endPointY {
        
        if (startPointX < endPointX) {
            for index in startPointX...endPointX {
                
                if board[String(index) + ":" + String(startPointY)] == nil {
                    board[String(index) + ":" + String(startPointY)] = 0
                }
                
                board[String(index) + ":" + String(startPointY)]! += 1
            }
        }
        else {
            for index in endPointX...startPointX {
                
                if board[String(index) + ":" + String(startPointY)] == nil {
                    board[String(index) + ":" + String(startPointY)] = 0
                }
                
                board[String(index) + ":" + String(startPointY)]! += 1
            }
        }
    }
}

let solution = board.filter { $0.value > 1}.count

print(solution)
