import Foundation

struct BoardNumber {
    
    var isSelected: Bool
    var row: Int
    var column: Int
    
    init(_ isSelected: Bool, _ row: Int, _ column: Int)
    {
        self.isSelected = isSelected
        self.row = row
        self.column = column
    }
    
    mutating func MarkAsSelected() -> Void {
        
        self.isSelected = true
        
    }
}

struct Board
{
    var numbers = [Int:BoardNumber]()
    var numberOfRows: Int
    var numberOfColumns: Int
        
    init(_ numbers: [Int:BoardNumber], _ columns: Int, _ rows: Int)
    {
        self.numbers = numbers
        self.numberOfRows = rows
        self.numberOfColumns = columns
    }
    
    func SumOfUnmarked() -> Int {
        
        return self.numbers.filter { $0.value.isSelected == false }
            .map { $0.key }
            .reduce(0, +)
    }
    
    mutating func MarkAsSelected(_ number: Int) -> Void {
        
        if self.numbers[number] != nil {
            
            self.numbers[number]!.MarkAsSelected()
        
        }
        
    }
    
    func HasRowSelected() -> Bool {
        
        for row in 0..<(numberOfRows) {
            
            if (self.numbers.filter({
                    $0.value.isSelected == true &&
                    $0.value.row == row
                }).count == numberOfColumns) {
                
                return true
                
            }
        }
        
        return false
    }
    
    func HasColumnSelected() -> Bool {
        
        for column in 0..<(numberOfColumns) {
            
            if (self.numbers.filter({
                    $0.value.isSelected == true &&
                    $0.value.column == column
                }).count == numberOfRows) {
                
                return true
                
            }
        }
        
        return false
    }
}

let path = Bundle.main.path(forResource: "input", ofType: "txt")
let fileContent = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)

let inputParts = fileContent.components(separatedBy: "\n\n").map { String($0) }

let chosenNumbers = inputParts[0].components(separatedBy: ",").map { Int($0)! }

var arrayOfBoards = [Board]()

for index in 1..<(inputParts.count) {
    
    var boardNumbers = [Int:BoardNumber]()
    
    var rows = inputParts[index].components(separatedBy: "\n")
    
    var columnCount = 0
    
    for rowIndex in 0..<(rows.count) {
        
        rows[rowIndex] = rows[rowIndex].replacingOccurrences(of: "  ", with: " ").trimmingCharacters(in: .whitespaces)
        
        let numbersInRow = rows[rowIndex].components(separatedBy: " ").map { Int($0)! }
        
        columnCount = numbersInRow.count
        
        for columnIndex in 0..<(columnCount) {
            
            var thisBoardNumber = BoardNumber(false, rowIndex, columnIndex)
            
            var s = numbersInRow[columnIndex]
            
            boardNumbers[numbersInRow[columnIndex]] = thisBoardNumber
        }
        
    }
    
    var thisBoard = Board(boardNumbers, columnCount, rows.count)
    
    arrayOfBoards.append(thisBoard)
    
}

for chosenNumber in chosenNumbers {
    
    for index in 0..<(arrayOfBoards.count) {
        
        arrayOfBoards[index].MarkAsSelected(chosenNumber)
        
        if arrayOfBoards[index].HasColumnSelected() || arrayOfBoards[index].HasRowSelected() {
            
            let unmarkedSum = arrayOfBoards[index].SumOfUnmarked()
            
            let solution = unmarkedSum * chosenNumber
            
            print(solution)
            
            exit(0)
        }
        
    }
        
}
