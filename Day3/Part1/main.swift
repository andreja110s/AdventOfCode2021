import Foundation

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}

let path = Bundle.main.path(forResource: "input", ofType: "txt")
let fileContent = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)

let inputParts = fileContent.components(separatedBy: "\n").map { String($0) }

var gamaRate = ""
var epsilonRate = ""

var minNumForMax = inputParts.count / 2

var zeros = 0

for index in 0..<(inputParts[0].count) {
    
    for item in inputParts {
        
        if item[index] == "0" {
            
            zeros += 1
        }
    }
    
    if zeros > minNumForMax {
        gamaRate += "0"
        epsilonRate += "1"
    }
    else {
        gamaRate += "1"
        epsilonRate += "0"
    }
    
    zeros = 0
}

var gammaRateDecimal = Int(gamaRate, radix: 2)!
var epsilonRateDecimal = Int(epsilonRate, radix: 2)!

print(gammaRateDecimal * epsilonRateDecimal)
