import Foundation

struct Cave {
    
    var isLarge: Bool
    var name: String
    var LeadsInto: [String]
    
    init(_ name: String) {
        self.name = name
        self.LeadsInto = [String]()
        
        if name.uppercased() == name {
            self.isLarge = true
        }
        else {
            self.isLarge = false
        }
    }
}

let path = Bundle.main.path(forResource: "input", ofType: "txt")
let fileContent = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)

let lines = fileContent.components(separatedBy: "\n").map { String($0) }

var caves = [Cave]()

var solution = 0

for line in lines {
    
    let mapping = line.components(separatedBy: "-").map { String($0) }
    
    var startingCave = caves.filter { $0.name == mapping[0]}.first
    var endCave = caves.filter { $0.name == mapping[1]}.first
    
    if startingCave == nil {
        startingCave = Cave(mapping[0])
        caves.append(startingCave!)
    }
    
    if endCave == nil {
        endCave = Cave(mapping[1])
        caves.append(endCave!)
    }
    
    if let index = caves.firstIndex(where: {$0.name == mapping[0]}) {
        caves[index].LeadsInto.append(mapping[1])
    }
    
    if let index = caves.firstIndex(where: {$0.name == mapping[1]}) {
        caves[index].LeadsInto.append(mapping[0])
    }
    
}

func DewIt(_ caveName: String, _ alreadyVisited: [String]) -> Void {
    
    if caveName == "end" {
        
        solution += 1
        return
    }
    
    let cave = caves.filter { $0.name == caveName }.first!
    
    if alreadyVisited.contains(caveName) && cave.isLarge == false {
        return
    }
    
    var updatedAlreadyVisited = alreadyVisited
    updatedAlreadyVisited.append(caveName)
    
    for nextCave in cave.LeadsInto {
        
        DewIt(nextCave, updatedAlreadyVisited)
    }
    
}

DewIt("start", [String]())

print(solution)
