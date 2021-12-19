import Foundation

let path = Bundle.main.path(forResource: "input", ofType: "txt")
let fileContent = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)

let lines = fileContent.components(separatedBy: "\n").map { String($0) }

var solution = 0

for line in lines {
    
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
                if character == "]" {
                    solution += 57
                }
                else if character == ")" {
                    solution += 3
                }
                else if character == "}" {
                    solution += 1197
                }
                else {
                    solution += 25137
                }
                
                break
            }
        }
    }
    
}

print(solution)
