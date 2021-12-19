import Foundation

extension String {
    typealias Byte = UInt8
    var hexaToBytes: [Byte] {
        var start = startIndex
        return stride(from: 0, to: count, by: 2).compactMap { _ in
            let end = index(after: start)
            defer { start = index(after: end) }
            return Byte(self[start...end], radix: 16)
        }
    }
    var hexaToBinary: String {
        return hexaToBytes.map {
            let binary = String($0, radix: 2)
            return repeatElement("0", count: 8-binary.count) + binary
        }.joined()
    }
}

let path = Bundle.main.path(forResource: "input", ofType: "txt")
let fileContent = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)

let binary = Array(fileContent.hexaToBinary)

var solution = 0

func ProcessPacket(_ startIndex: Int, _ endIndex: Int) -> (String, Int) {
    
    var packetFinalValue = ""
    
    let packetVersion = Int(String(binary[startIndex...(startIndex + 2)]), radix: 2)!
    let packetType = Int(String(binary[(startIndex + 3)...(startIndex + 5)]), radix: 2)!
    
    solution += packetVersion
    
    var index = startIndex + 6
    
    if packetType == 4 {
        
        while true {
            
            packetFinalValue += binary[(index + 1)..<(index + 5)]
            
            if binary[index] == "0" {
                break
            }
            
            index += 5
        }
        
        return (packetFinalValue, index + 5)
        
    }
    else {
        
        let lengthType = binary[startIndex + 6]
        
        if lengthType == "0" {
            
            let totalLengthInBits = Int(String(binary[(startIndex + 7)...(startIndex + 7 + 14)]), radix: 2)!
            
            var newStartIndex = startIndex + 7 + 15
            let newEndIndex = startIndex + 7 + 15 + totalLengthInBits
            
            var funcResult: (String, Int)
            
            while true {
                
                funcResult = ProcessPacket(newStartIndex, newEndIndex)
                
                packetFinalValue += funcResult.0
                
                if funcResult.1 == newEndIndex {
                    return (packetFinalValue, newEndIndex)
                }
                
                newStartIndex = funcResult.1
            }
            
        }
        else {
            
            let numberOfPackages = Int(String(binary[(startIndex + 7)...(startIndex + 7 + 10)]), radix: 2)!
            
            var newStartIndex = startIndex + 7 + 11
            let newEndIndex = endIndex
            
            var currentPackagesProcessed = 0
            
            var funcResult: (String, Int)
            funcResult = ("", 0)
            
            while currentPackagesProcessed < numberOfPackages {
                
                funcResult = ProcessPacket(newStartIndex, newEndIndex)
                
                packetFinalValue += funcResult.0
                
                if funcResult.1 == newEndIndex {
                    return (packetFinalValue, newEndIndex)
                }
                
                newStartIndex = funcResult.1
                
                currentPackagesProcessed += 1
            }
            
            return (packetFinalValue, funcResult.1)
        }
    }
    
}

let processedEntry = ProcessPacket(0, binary.count - 1)

print(solution)
