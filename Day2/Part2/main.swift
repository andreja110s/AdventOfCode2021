import Foundation

let path = Bundle.main.path(forResource: "input", ofType: "txt")

let fileContent = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)

let commands = fileContent.components(separatedBy: "\n").map { String($0) }

var horizontalPosition = 0
var depth = 0
var aim = 0
var solution: Int

var partsOfCommand = [String]()
var movement: String
var value: Int

for command in commands {
    
    partsOfCommand = command.components(separatedBy: " ")

    movement = partsOfCommand[0]
    value = Int(partsOfCommand[1])!
    
    if movement == "forward" {
        horizontalPosition += value
        depth += aim * value
    }
    else if movement == "down" {
        aim += value
    }
    else if movement == "up" {
        aim -= value
    }
}

solution = horizontalPosition * depth

print(solution)
