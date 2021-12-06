import Foundation

let path = Bundle.main.path(forResource: "input", ofType: "txt")
let fileContent = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)

let initialFishTimers = fileContent.components(separatedBy: ",").map { Int($0)! }

var fishTimers = [Int](repeating: 0, count: 9)

var fishTimersCopy = [Int](repeating: 0, count: 9)

for initialFishTimer in initialFishTimers {
    fishTimers[initialFishTimer] += 1
}

for _ in 0..<256 {
    
    fishTimersCopy[0] = fishTimers[1]
    fishTimersCopy[1] = fishTimers[2]
    fishTimersCopy[2] = fishTimers[3]
    fishTimersCopy[3] = fishTimers[4]
    fishTimersCopy[4] = fishTimers[5]
    fishTimersCopy[5] = fishTimers[6]
    fishTimersCopy[6] = fishTimers[7] + fishTimers[0]
    
    fishTimersCopy[7] = fishTimers[8]
    fishTimersCopy[8] = fishTimers[0]
    
    fishTimers = fishTimersCopy
    
    fishTimersCopy = [Int](repeating: 0, count: 9)
    
}

let solution = fishTimers.reduce(0, +)

print(solution)
