import Foundation

let path = Bundle.main.path(forResource: "input", ofType: "txt")
let fileContent = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)

let crabLocations = fileContent.components(separatedBy: ",").map { Int($0)! }.sorted()

var solution = 0

for crabLocation in crabLocations {
     
    let n = abs(0 - crabLocation)
    
    let totalSum = n * (n + 1 ) / 2
    
    solution += totalSum
}

for index in 1...crabLocations.max()! {
    
    var thisLocationSums = 0
    
    for crabLocation in crabLocations {
         
        let n = abs(index - crabLocation)
        
        let totalSum = n * (n + 1 ) / 2
        
        thisLocationSums += totalSum
        
        if thisLocationSums > solution {
            break
        }
    }
    
    if thisLocationSums < solution {
        solution = thisLocationSums
    }
    
}

print(solution)
