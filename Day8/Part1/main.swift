import Foundation

let path = Bundle.main.path(forResource: "input", ofType: "txt")
let fileContent = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)

let entries = fileContent.components(separatedBy: "\n").map { String($0) }

let viableSegmentCounts = [2, 4, 3, 7]

var solution = 0

for entry in entries {
    
    let partsOfEntry = entry.components(separatedBy: " | ").map { String($0) }
    
    let outputDigits = partsOfEntry[1].components(separatedBy: " ").map { String($0) }
    
    for outputDigit in outputDigits {
        
        let uniqueSegments = outputDigit.count
        
        if viableSegmentCounts.contains(uniqueSegments) {
            
            solution += 1
            
        }
    }
}

print(solution)
