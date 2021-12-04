import Foundation

let path = Bundle.main.path(forResource: "input", ofType: "txt")

let fileContent = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)

let partsOfInput = fileContent.components(separatedBy: "\n").map { Int($0)! }

var solution = 0

var currentItem = partsOfInput[0]

for index in 1..<(partsOfInput.count - 1)
{
    if partsOfInput[index] > currentItem
    {
        solution += 1
    }
    
    currentItem = partsOfInput[index]
}

print(solution)
