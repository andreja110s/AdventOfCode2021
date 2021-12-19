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

func ProcessPacket(_ startIndex: Int, _ endIndex: Int) -> (Int, Int) {
    
    let packetVersion = Int(String(binary[startIndex...(startIndex + 2)]), radix: 2)!
    let packetType = Int(String(binary[(startIndex + 3)...(startIndex + 5)]), radix: 2)!
    
    var index = startIndex + 6
    
    if packetType == 0 {
        
        var packetSolution = 0
        
        let lengthType = binary[startIndex + 6]
        
        if lengthType == "0" {
            
            let totalLengthInBits = Int(String(binary[(startIndex + 7)...(startIndex + 7 + 14)]), radix: 2)!
            
            var newStartIndex = startIndex + 7 + 15
            let newEndIndex = startIndex + 7 + 15 + totalLengthInBits
            
            var funcResult: (Int, Int)
            
            while true {
                
                funcResult = ProcessPacket(newStartIndex, newEndIndex)
                
                packetSolution += funcResult.1
                
                if funcResult.0 == newEndIndex {
                    return (newEndIndex, packetSolution)
                }
                
                newStartIndex = funcResult.0
            }
            
        }
        else {
            
            let numberOfPackages = Int(String(binary[(startIndex + 7)...(startIndex + 7 + 10)]), radix: 2)!
            
            var newStartIndex = startIndex + 7 + 11
            let newEndIndex = endIndex
            
            var currentPackagesProcessed = 0
            
            var funcResult: (Int, Int)
            funcResult = (0, 0)
            
            while currentPackagesProcessed < numberOfPackages {
                
                funcResult = ProcessPacket(newStartIndex, newEndIndex)
                
                packetSolution += funcResult.1
                
                if funcResult.0 == newEndIndex {
                    return (newEndIndex, packetSolution)
                }
                
                newStartIndex = funcResult.0
                
                currentPackagesProcessed += 1
            }
            
            return (funcResult.0, packetSolution)
        }
    }
    else if packetType == 1 {
        
        var packetSolution = 1
        
        let lengthType = binary[startIndex + 6]
        
        if lengthType == "0" {
            
            let totalLengthInBits = Int(String(binary[(startIndex + 7)...(startIndex + 7 + 14)]), radix: 2)!
            
            var newStartIndex = startIndex + 7 + 15
            let newEndIndex = startIndex + 7 + 15 + totalLengthInBits
            
            var funcResult: (Int, Int)
            
            while true {
                
                funcResult = ProcessPacket(newStartIndex, newEndIndex)
                
                packetSolution *= funcResult.1
                
                if funcResult.0 == newEndIndex {
                    return (newEndIndex, packetSolution)
                }
                
                newStartIndex = funcResult.0
            }
            
        }
        else {
            
            let numberOfPackages = Int(String(binary[(startIndex + 7)...(startIndex + 7 + 10)]), radix: 2)!
            
            var newStartIndex = startIndex + 7 + 11
            let newEndIndex = endIndex
            
            var currentPackagesProcessed = 0
            
            var funcResult: (Int, Int)
            funcResult = (0, 0)
            
            while currentPackagesProcessed < numberOfPackages {
                
                funcResult = ProcessPacket(newStartIndex, newEndIndex)
                
                packetSolution *= funcResult.1
                
                if funcResult.0 == newEndIndex {
                    return (newEndIndex, packetSolution)
                }
                
                newStartIndex = funcResult.0
                
                currentPackagesProcessed += 1
            }
            
            return (funcResult.0, packetSolution)
        }
    }
    else if packetType == 2 {
        
        var packetSolution = Int.max
        
        let lengthType = binary[startIndex + 6]
        
        if lengthType == "0" {
            
            let totalLengthInBits = Int(String(binary[(startIndex + 7)...(startIndex + 7 + 14)]), radix: 2)!
            
            var newStartIndex = startIndex + 7 + 15
            let newEndIndex = startIndex + 7 + 15 + totalLengthInBits
            
            var funcResult: (Int, Int)
            
            while true {
                
                funcResult = ProcessPacket(newStartIndex, newEndIndex)
                
                if funcResult.1 < packetSolution {
                    packetSolution = funcResult.1
                }
                
                if funcResult.0 == newEndIndex {
                    return (newEndIndex, packetSolution)
                }
                
                newStartIndex = funcResult.0
            }
            
        }
        else {
            
            let numberOfPackages = Int(String(binary[(startIndex + 7)...(startIndex + 7 + 10)]), radix: 2)!
            
            var newStartIndex = startIndex + 7 + 11
            let newEndIndex = endIndex
            
            var currentPackagesProcessed = 0
            
            var funcResult: (Int, Int)
            funcResult = (0, 0)
            
            while currentPackagesProcessed < numberOfPackages {
                
                funcResult = ProcessPacket(newStartIndex, newEndIndex)
                
                if funcResult.1 < packetSolution {
                    packetSolution = funcResult.1
                }
                
                if funcResult.0 == newEndIndex {
                    return (newEndIndex, packetSolution)
                }
                
                newStartIndex = funcResult.0
                
                currentPackagesProcessed += 1
            }
            
            return (funcResult.0, packetSolution)
        }
    }
    else if packetType == 3 {
        
        var packetSolution = 0
        
        let lengthType = binary[startIndex + 6]
        
        if lengthType == "0" {
            
            let totalLengthInBits = Int(String(binary[(startIndex + 7)...(startIndex + 7 + 14)]), radix: 2)!
            
            var newStartIndex = startIndex + 7 + 15
            let newEndIndex = startIndex + 7 + 15 + totalLengthInBits
            
            var funcResult: (Int, Int)
            
            while true {
                
                funcResult = ProcessPacket(newStartIndex, newEndIndex)
                
                if funcResult.1 > packetSolution {
                    packetSolution = funcResult.1
                }
                
                if funcResult.0 == newEndIndex {
                    return (newEndIndex, packetSolution)
                }
                
                newStartIndex = funcResult.0
            }
            
        }
        else {
            
            let numberOfPackages = Int(String(binary[(startIndex + 7)...(startIndex + 7 + 10)]), radix: 2)!
            
            var newStartIndex = startIndex + 7 + 11
            let newEndIndex = endIndex
            
            var currentPackagesProcessed = 0
            
            var funcResult: (Int, Int)
            funcResult = (0, 0)
            
            while currentPackagesProcessed < numberOfPackages {
                
                funcResult = ProcessPacket(newStartIndex, newEndIndex)
                
                if funcResult.1 > packetSolution {
                    packetSolution = funcResult.1
                }
                
                if funcResult.0 == newEndIndex {
                    return (newEndIndex, packetSolution)
                }
                
                newStartIndex = funcResult.0
                
                currentPackagesProcessed += 1
            }
            
            return (funcResult.0, packetSolution)
        }
    }
    else if packetType == 4 {
        
        var packetFinalValue = ""
        
        while true {
            
            packetFinalValue += binary[(index + 1)..<(index + 5)]
            
            if binary[index] == "0" {
                break
            }
            
            index += 5
        }
        
        return (index + 5, Int(packetFinalValue, radix: 2)!)
        
    }
    else if packetType == 5 {
        
        var firstPacketValue = -1
        
        var packetSolution = 0
        
        let lengthType = binary[startIndex + 6]
        
        if lengthType == "0" {
            
            let totalLengthInBits = Int(String(binary[(startIndex + 7)...(startIndex + 7 + 14)]), radix: 2)!
            
            var newStartIndex = startIndex + 7 + 15
            let newEndIndex = startIndex + 7 + 15 + totalLengthInBits
            
            var funcResult: (Int, Int)
            
            while true {
                
                funcResult = ProcessPacket(newStartIndex, newEndIndex)
                
                if firstPacketValue == -1 {
                    firstPacketValue = funcResult.1
                }
                else {
                    
                    if firstPacketValue > funcResult.1 {
                        packetSolution = 1
                    }
                    
                }
                
                if funcResult.0 == newEndIndex {
                    return (newEndIndex, packetSolution)
                }
                
                newStartIndex = funcResult.0
            }
            
        }
        else {
            
            let numberOfPackages = Int(String(binary[(startIndex + 7)...(startIndex + 7 + 10)]), radix: 2)!
            
            var newStartIndex = startIndex + 7 + 11
            let newEndIndex = endIndex
            
            var currentPackagesProcessed = 0
            
            var funcResult: (Int, Int)
            funcResult = (0, 0)
            
            while currentPackagesProcessed < numberOfPackages {
                
                funcResult = ProcessPacket(newStartIndex, newEndIndex)
                
                if firstPacketValue == -1 {
                    firstPacketValue = funcResult.1
                }
                else {
                    
                    if firstPacketValue > funcResult.1 {
                        packetSolution = 1
                    }
                    
                }
                
                if funcResult.0 == newEndIndex {
                    return (newEndIndex, packetSolution)
                }
                
                newStartIndex = funcResult.0
                
                currentPackagesProcessed += 1
            }
            
            return (funcResult.0, packetSolution)
        }
    }
    else if packetType == 6 {
        
        var firstPacketValue = -1
        
        var packetSolution = 0
        
        let lengthType = binary[startIndex + 6]
        
        if lengthType == "0" {
            
            let totalLengthInBits = Int(String(binary[(startIndex + 7)...(startIndex + 7 + 14)]), radix: 2)!
            
            var newStartIndex = startIndex + 7 + 15
            let newEndIndex = startIndex + 7 + 15 + totalLengthInBits
            
            var funcResult: (Int, Int)
            
            while true {
                
                funcResult = ProcessPacket(newStartIndex, newEndIndex)
                
                if firstPacketValue == -1 {
                    firstPacketValue = funcResult.1
                }
                else {
                    
                    if firstPacketValue < funcResult.1 {
                        packetSolution = 1
                    }
                    
                }
                
                if funcResult.0 == newEndIndex {
                    return (newEndIndex, packetSolution)
                }
                
                newStartIndex = funcResult.0
            }
            
        }
        else {
            
            let numberOfPackages = Int(String(binary[(startIndex + 7)...(startIndex + 7 + 10)]), radix: 2)!
            
            var newStartIndex = startIndex + 7 + 11
            let newEndIndex = endIndex
            
            var currentPackagesProcessed = 0
            
            var funcResult: (Int, Int)
            funcResult = (0, 0)
            
            while currentPackagesProcessed < numberOfPackages {
                
                funcResult = ProcessPacket(newStartIndex, newEndIndex)
                
                if firstPacketValue == -1 {
                    firstPacketValue = funcResult.1
                }
                else {
                    
                    if firstPacketValue < funcResult.1 {
                        packetSolution = 1
                    }
                    
                }
                
                if funcResult.0 == newEndIndex {
                    return (newEndIndex, packetSolution)
                }
                
                newStartIndex = funcResult.0
                
                currentPackagesProcessed += 1
            }
            
            return (funcResult.0, packetSolution)
        }
    }
    else { //if packetType == 7 {
        
        var firstPacketValue = -1
        
        var packetSolution = 0
        
        let lengthType = binary[startIndex + 6]
        
        if lengthType == "0" {
            
            let totalLengthInBits = Int(String(binary[(startIndex + 7)...(startIndex + 7 + 14)]), radix: 2)!
            
            var newStartIndex = startIndex + 7 + 15
            let newEndIndex = startIndex + 7 + 15 + totalLengthInBits
            
            var funcResult: (Int, Int)
            
            while true {
                
                funcResult = ProcessPacket(newStartIndex, newEndIndex)
                
                if firstPacketValue == -1 {
                    firstPacketValue = funcResult.1
                }
                else {
                    
                    if firstPacketValue == funcResult.1 {
                        packetSolution = 1
                    }
                    
                }
                
                if funcResult.0 == newEndIndex {
                    return (newEndIndex, packetSolution)
                }
                
                newStartIndex = funcResult.0
            }
            
        }
        else {
            
            let numberOfPackages = Int(String(binary[(startIndex + 7)...(startIndex + 7 + 10)]), radix: 2)!
            
            var newStartIndex = startIndex + 7 + 11
            let newEndIndex = endIndex
            
            var currentPackagesProcessed = 0
            
            var funcResult: (Int, Int)
            funcResult = (0, 0)
            
            while currentPackagesProcessed < numberOfPackages {
                
                funcResult = ProcessPacket(newStartIndex, newEndIndex)
                
                if firstPacketValue == -1 {
                    firstPacketValue = funcResult.1
                }
                else {
                    
                    if firstPacketValue == funcResult.1 {
                        packetSolution = 1
                    }
                    
                }
                
                if funcResult.0 == newEndIndex {
                    return (newEndIndex, packetSolution)
                }
                
                newStartIndex = funcResult.0
                
                currentPackagesProcessed += 1
            }
            
            return (funcResult.0, packetSolution)
        }
    }
    
}

let processedEntry = ProcessPacket(0, binary.count - 1)

print(processedEntry.1)
