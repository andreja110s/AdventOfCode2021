import Foundation

let path = Bundle.main.path(forResource: "input", ofType: "txt")
let fileContent = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)

let entries = fileContent.components(separatedBy: "\n").map { String($0) }

var solution = 0

var mappingTable = [Character:Character]()

for entry in entries {
    
    var outputValue = ""
        
    let allNumbers = entry.replacingOccurrences(of: " | ", with: " ")
        .components(separatedBy: " ").map { String($0) }
    
    let charsOfOne = Array(allNumbers.filter { $0.count == 2}.first!)
    let charsOfFour = Array(allNumbers.filter { $0.count == 4}.first!)
    let charsOfSeven = Array(allNumbers.filter { $0.count == 3}.first!)
    
    //we find the "a" by comparing what we know to be 1 and 7
    mappingTable["a"] = charsOfSeven.filter { charsOfOne.contains($0) == false }.first
        
    //find number 3
    let numberThree = allNumbers.filter {
        $0.count == 5 &&
        $0.contains(charsOfOne[0]) &&
        $0.contains(charsOfOne[1])
    }.first!
    
    mappingTable["g"] = Array(numberThree).filter {
        !charsOfFour.contains($0) &&
        $0 != mappingTable["a"]
    }.first
    
    mappingTable["d"] = Array(numberThree).filter {
        !charsOfSeven.contains($0) &&
        $0 != mappingTable["g"]
    }.first
    
    mappingTable["b"] = charsOfFour.filter { !Array(numberThree).contains($0) }.first
    
    //find number 5
    let numberFive = allNumbers.filter {
        $0.count == 5 &&
        $0.contains(mappingTable["b"]!)
    }.first!
    
    mappingTable["f"] = Array(numberFive).filter {
        $0 != mappingTable["a"] &&
        $0 != mappingTable["b"] &&
        $0 != mappingTable["d"] &&
        $0 != mappingTable["g"]
    }.first!
    
    mappingTable["c"] = charsOfOne.filter { $0 != mappingTable["f"] }.first!
    
    //find number zero
    let numberZero = allNumbers.filter {
        $0.count == 6 &&
        !$0.contains(mappingTable["d"]!)
    }.first!
    
    mappingTable["e"] = Array(numberZero).filter {
        $0 != mappingTable["a"] &&
        $0 != mappingTable["b"] &&
        $0 != mappingTable["c"] &&
        $0 != mappingTable["f"] &&
        $0 != mappingTable["g"]
    }.first!
    
    let partsOfEntry = entry.components(separatedBy: " | ").map { String($0) }
    
    let outputNumbers = partsOfEntry[1].components(separatedBy: " ").map {String($0)}
    
    for outputNumber in outputNumbers {
        
        if outputNumber.count == 2 {
            outputValue += "1"
        }
        else if outputNumber.count == 3 {
            outputValue += "7"
        }
        else if outputNumber.count == 4 {
            outputValue += "4"
        }
        else if outputNumber.count == 7 {
            outputValue += "8"
        }
        else if outputNumber.count == 5 {

            if outputNumber.contains(mappingTable["e"]!) {
                outputValue += "2"
            }
            else if outputNumber.contains(mappingTable["b"]!) {
                outputValue += "5"
            }
            else {
                outputValue += "3"
            }
        }
        else if outputNumber.count == 6 {
            
            if !outputNumber.contains(mappingTable["d"]!) {
                outputValue += "0"
            }
            else if outputNumber.contains(mappingTable["e"]!) {
                outputValue += "6"
            }
            else {
                outputValue += "9"
            }
        }
    }
    
    solution += Int(outputValue)!
}

print(solution)
