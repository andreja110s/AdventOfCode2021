import Foundation

struct Polymer {
    
    var name: String
    var count: Int
    var nextIterationValue: Int
    var inserts: Character
    
    init(_ name: String, _ inserts: Character) {
        self.name = name
        self.count = 0
        self.nextIterationValue = 0
        self.inserts = inserts
    }
}

let path = Bundle.main.path(forResource: "input", ofType: "txt")
let fileContent = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)

let partsOfInput = fileContent.components(separatedBy: "\n\n").map { String($0) }

let template = Array(partsOfInput[0])

let instructions = partsOfInput[1].components(separatedBy: "\n").map { String($0)}

var pairsOfPolymer = [Polymer]()

var uniquePolymers = [String:Int]()

for instruction in instructions {
    
    let partsOfInstructions = instruction.components(separatedBy: " -> ").map { String($0) }
    
    let newPolymer = Polymer(partsOfInstructions[0], Character(partsOfInstructions[1]))
    
    pairsOfPolymer.append(newPolymer)
    
    if uniquePolymers[partsOfInstructions[1]] == nil {
        uniquePolymers[partsOfInstructions[1]] = 0
    }
}

//initialize the array
for templateIndex in 0..<(template.count - 1) {
    
    let pairName = String(template[templateIndex]) + String(template[templateIndex + 1])
    
    if let index = pairsOfPolymer.firstIndex(where: { $0.name == pairName }) {
        
        pairsOfPolymer[index].count += 1
        
    }
    
    uniquePolymers[String(template[templateIndex])]! += 1
    
}

uniquePolymers[String(template[template.count - 1])]! += 1

for _ in 0...9 {
    
    for indexOfPolimer in 0..<(pairsOfPolymer.count) {
        
        if (pairsOfPolymer[indexOfPolimer].count != 0) {
            
            let partsOfPolymerName = Array(pairsOfPolymer[indexOfPolimer].name).map {String ($0) }
            
            let polymerToInsert = String(pairsOfPolymer[indexOfPolimer].inserts)
            
            var wasInserted = false
            
            if let index = pairsOfPolymer.firstIndex(where: { $0.name == partsOfPolymerName[0] + polymerToInsert }) {
                
                pairsOfPolymer[index].nextIterationValue += pairsOfPolymer[indexOfPolimer].count
                wasInserted = true
                
            }
            
            if let index = pairsOfPolymer.firstIndex(where: { $0.name == polymerToInsert + partsOfPolymerName[1] }) {
                
                pairsOfPolymer[index].nextIterationValue += pairsOfPolymer[indexOfPolimer].count
                
                wasInserted = true
                
            }
            
            if wasInserted == true {
                
                uniquePolymers[polymerToInsert]! += pairsOfPolymer[indexOfPolimer].count
                
                pairsOfPolymer[indexOfPolimer].nextIterationValue -= pairsOfPolymer[indexOfPolimer].count
                
            }
            
        }
        
    }
    
    for indexOfPolimer in 0..<(pairsOfPolymer.count) {
        
        pairsOfPolymer[indexOfPolimer].count += pairsOfPolymer[indexOfPolimer].nextIterationValue
        
        pairsOfPolymer[indexOfPolimer].nextIterationValue = 0
        
    }
    
}

var mostCommonElement = uniquePolymers.map { $0.value }.max()!
var leastCommonElement = uniquePolymers.map { $0.value }.min()!

print(mostCommonElement - leastCommonElement)
