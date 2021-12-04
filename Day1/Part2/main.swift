import Foundation

let path = Bundle.main.path(forResource: "input", ofType: "txt")

let fileContent = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)

let partsOfInput = fileContent.components(separatedBy: "\n").map { Int($0)! }

var sums = [Int]()

let t = partsOfInput.count % 3

for i in 0..<(partsOfInput.count - (partsOfInput.count % 3)) {
    sums.append(Array(partsOfInput[i..<(i + 3)]).reduce(0, +))
}

var current = sums[0]

var solution = 0

for index in 1..<(sums.count) {
    
    //print("Checking for " + String(sums[index]))
    
    if current < sums[index] {
        
        //print("Current " + String(current) + " is smaller than " + String(sums[index]))
        solution += 1
    }
    
    current = sums[index]
}

print(solution)
