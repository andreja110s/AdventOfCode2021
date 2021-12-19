import Foundation

let path = Bundle.main.path(forResource: "input", ofType: "txt")
let fileContent = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)

let lines = fileContent.components(separatedBy: "\n").map { String($0) }
var invalidLines = [String]()

var scores = [Int]()

for line in lines {
    
    var isCorrupted = false
    
    var openingChunk = [Character]()
        
    for character in Array(line) {
        
        if character == "[" || character == "(" || character == "{" || character == "<" {
            openingChunk.append(character)
            continue
        }
        else {
            if character == "]" && openingChunk.last == "[" {
                openingChunk.removeLast(1)
            }
            else if character == ")" && openingChunk.last == "(" {
                openingChunk.removeLast(1)
            }
            else if character == "}" && openingChunk.last == "{" {
                openingChunk.removeLast(1)
            }
            else if character == ">" && openingChunk.last == "<" {
                openingChunk.removeLast(1)
            }
            else {
                
                isCorrupted = true
                
                break
            }
        }
    }
    
    if !isCorrupted {
        invalidLines.append(line)
    }
    
}

for invalidLine in invalidLines {
    
    var lineTmp = invalidLine
        
    var lineScore = 0
    
    while true {
        
        if lineTmp.contains("[]") {
            
            lineTmp = lineTmp.replacingOccurrences(of: "[]", with: "")
            continue
        }
        if lineTmp.contains("()") {
            
            lineTmp = lineTmp.replacingOccurrences(of: "()", with: "")
            continue
        }
        if lineTmp.contains("{}") {
            
            lineTmp = lineTmp.replacingOccurrences(of: "{}", with: "")
            continue
        }
        if lineTmp.contains("<>") {
            
            lineTmp = lineTmp.replacingOccurrences(of: "<>", with: "")
            continue
        }
        
        break
        
    }
    
    let lineTmpArray = Array(lineTmp)
    
    for index in (0..<(lineTmp.count)).reversed() {
        
        if lineTmpArray[index] == "[" {
            lineScore = (lineScore * 5) + 2
        }
        else if lineTmpArray[index] == "(" {
            lineScore = (lineScore * 5) + 1
        }
        else if lineTmpArray[index] == "{" {
            lineScore = (lineScore * 5) + 3
        }
        else {
            lineScore = (lineScore * 5) + 4
        }
        
    }
    
    scores.append(lineScore)
}

scores.sort(by: >)

let solution = scores[scores.count / 2]

print(solution)
