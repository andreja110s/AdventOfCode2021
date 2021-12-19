import Foundation

let path = Bundle.main.path(forResource: "input", ofType: "txt")
let fileContent = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)

let lines = fileContent.components(separatedBy: "\n\n").map { String($0) }

let dots = lines[0].components(separatedBy: "\n").map { String($0) }
let instructions = lines[1].components(separatedBy: "\n").map { String($0) }

var paperDots = [String:Int]()

var solution = ""

var lastX = 0
var lastY = 0

for dot in dots {
    
    let dotCoordinates = dot.components(separatedBy: ",").map { Int($0)! }
    
    paperDots["\(dotCoordinates[1]):\(dotCoordinates[0])"] = 1
    
}

func Fold(_ line: String, _ coordinate: Int) -> Void {
    
    if line == "x" {
        
        for (dotCoordinateString, value) in paperDots {
            
            let dotCoordinates = dotCoordinateString.components(separatedBy: ":").map { Int($0)! }
            
            if dotCoordinates[1] > coordinate && value == 1 {
                
                let diff = dotCoordinates[1] - coordinate
                
                paperDots["\(dotCoordinates[0]):\(coordinate - diff)"] = 1
                
                paperDots.removeValue(forKey: "\(dotCoordinates[0]):\(dotCoordinates[1])")
                
            }
            
        }
        
        lastX = coordinate
        
    }
    else {
        
        for (dotCoordinateString, value) in paperDots {
            
            let dotCoordinates = dotCoordinateString.components(separatedBy: ":").map { Int($0)! }
            
            if dotCoordinates[0] > coordinate && value == 1 {
                
                let diff = dotCoordinates[0] - coordinate
                
                paperDots["\(coordinate - diff):\(dotCoordinates[1])"] = 1
                
                paperDots.removeValue(forKey: "\(dotCoordinates[0]):\(dotCoordinates[1])")
            }
            
        }
        
        lastY = coordinate
        
    }
    
}

for instruction in instructions {
    
    let foldData = instruction.components(separatedBy: "fold along ").map { String($0) }.last!.components(separatedBy: "=").map { String($0) }
    
    let line = foldData[0]
    let coordinate = Int(foldData[1])!
    
    Fold(line, coordinate)

}

for indexX in 0..<(lastY) {
    
    var lineY = ""
    
    for indexY in 0..<(lastX) {
        
        if paperDots["\(indexX):\(indexY)"] == nil {
            lineY += "."
        }
        else {
            lineY += "#"
        }
    }
    
    solution += lineY + "\n"
}

print(solution)
