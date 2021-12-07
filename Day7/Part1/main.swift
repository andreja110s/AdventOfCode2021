import Foundation

let path = Bundle.main.path(forResource: "input", ofType: "txt")
let fileContent = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)

let crabLocations = fileContent.components(separatedBy: ",").map { Int($0)! }.sorted()

var solution = crabLocations.map { abs(0 - $0) }.reduce(0, +)

for index in 1...crabLocations.max()! {
    
    var thisLocationSums = 0
    
    for crabLocation in crabLocations {
        
        thisLocationSums += abs(index - crabLocation)
         
        if thisLocationSums > solution {
            break
        }
        
    }
    
    if thisLocationSums < solution {
        solution = thisLocationSums
    }
    
}

print(solution)
