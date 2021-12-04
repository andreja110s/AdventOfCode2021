import Foundation

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}

func ReturnCorrespondingMaxNumbers(_ numbers: [String], _ filterIndex: Int) -> [String]
{
    if numbers.count == 1 {
        return numbers
    }
    
    var minForMax = numbers.count / 2
    
    if numbers.count % 2 == 1 {
        minForMax += 1
    }
    
    var filterCount = 0
    
    var correspondingNumbers = [String]()
    
    for item in numbers {
        
        if String(item[filterIndex]) == "1" {
            
            filterCount += 1
        }
    }
    
    if filterCount >= minForMax {
        correspondingNumbers.append(contentsOf: numbers.filter {
            return $0[filterIndex] == "1" })
    }
    else {
        correspondingNumbers.append(contentsOf: numbers.filter {
            return $0[filterIndex] == "0" })
    }
    
    let nextFilterIndex = filterIndex + 1
    
    return ReturnCorrespondingMaxNumbers(correspondingNumbers, nextFilterIndex)
}

func ReturnCorrespondingMinNumbers(_ numbers: [String], _ filterIndex: Int) -> [String]
{
    if numbers.count == 1 {
        return numbers
    }
    
    let minForMax = numbers.count / 2
    
    var filterCount = 0
    
    var correspondingNumbers = [String]()
    
    for item in numbers {
        
        if String(item[filterIndex]) == "0" {
            
            filterCount += 1
        }
    }
    
    if filterCount <= minForMax {
        correspondingNumbers.append(contentsOf: numbers.filter {
            return $0[filterIndex] == "0" })
    }
    else {
        correspondingNumbers.append(contentsOf: numbers.filter {
            return $0[filterIndex] == "1" })
    }
    
    let nextFilterIndex = filterIndex + 1
    
    return ReturnCorrespondingMinNumbers(correspondingNumbers, nextFilterIndex)
}

let path = Bundle.main.path(forResource: "input", ofType: "txt")
let fileContent = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)

let inputParts = fileContent.components(separatedBy: "\n").map { String($0) }

var gamaRate = ReturnCorrespondingMaxNumbers(inputParts, 0)[0]
var epsilonRate = ReturnCorrespondingMinNumbers(inputParts, 0)[0]

var gammaRateDecimal = Int(gamaRate, radix: 2)!
var epsilonRateDecimal = Int(epsilonRate, radix: 2)!

print(gammaRateDecimal * epsilonRateDecimal)
