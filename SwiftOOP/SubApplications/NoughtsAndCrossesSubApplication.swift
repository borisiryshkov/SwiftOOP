class NoughtsAndCrossesSubApplication: SubApplication {
    init() {
        super.init(
            command: "t",
            description: "Launch the Noughts and Crosses game",
            message: "Welcome to Noughts and Crosses!"
        )
    }
    
    private let symbols = (
        player1: "X",
        player2: "O",
        nothing: " "
    )

    private var player1Name: String = ""
    private var player2Name: String = ""

    private var boardSize = 0

    private var board: [[Bool?]] = []

    private var playerState = true
    
    override func runMenu() -> SubApplicationAction {
        let startGame = UserDataProvider.enterString("For a new game, enter 'b'. To exit, enter 'q'.")
        switch startGame {
        case "b":
            break
        case "q":
            return .quit
        default:
            print("Invalid input. Please enter 'b' or 'q'")
        }
        player1Name = UserDataProvider.enterString("Please enter the player 1 name:")
        player2Name = UserDataProvider.enterString("Please enter the player 2 name:")
        while boardSize < 3 {
            UserDataProvider.enterInteger("Please enter the size of the board (minimum 3):", targetVar: &boardSize)
        }
        board = Array(repeating: Array(repeating: nil, count: boardSize), count: boardSize)
        while true {
            printField()
            print(currentPlayerText("'s turn"))
            if enterMove() {
                if checkWinRow() || checkWinColumn() || checkWinCross() {
                    printField()
                    print(currentPlayerText(" has won!"))
                    break
                }
                playerState.toggle()
            }
        }
        return .resume
    }

    private func currentPlayerText(_ playerText: String) -> String {
        if playerState {
            return "\(player1Name + playerText)"
        } else {
            return "\(player2Name + playerText)"
        }
    }

    private func allSame(_ elements: [Bool?]) -> Bool {
        return elements.allSatisfy({ $0 == true }) || elements.allSatisfy({ $0 == false })
    }

    private func enterMove() -> Bool {
        var row = 0
        var column = 0
        while row < 1 {
            UserDataProvider.enterInteger("Enter the row number to place your mark", targetVar: &row)
        }
        while column < 1 {
            UserDataProvider.enterInteger("Enter the column number to place your mark", targetVar: &column)
        }
        if row > boardSize || column > boardSize {
            print("That spot is not on the board, please choose another.")
            return false
        }
        let rowIndex = row - 1
        let columnIndex = column - 1
        if board[rowIndex][columnIndex] != nil {
            print("That spot is already taken, please choose another.")
            return false
        }
        if playerState {
            board[rowIndex][columnIndex] = true
        } else {
            board[rowIndex][columnIndex] = false
        }
        return true
    }

    private func printField() {
        var fieldFormattedString: String = "\n"
        for row in board {
            fieldFormattedString += "|"
            for cell in row {
                switch cell {
                case true: fieldFormattedString += symbols.player1
                case false: fieldFormattedString += symbols.player2
                case nil: fieldFormattedString += symbols.nothing
                }
                fieldFormattedString += "|"
            }
            fieldFormattedString += "\n"
        }
        print(fieldFormattedString)
    }

    private func checkWinRow() -> Bool {
        for row in board {
            if allSame(row) {
                return true
            }
        }
        return false
    }

    private func checkWinColumn() -> Bool {
        for rowCount in 0..<board.count {
            var columnElements: [Bool?] = []
            for row in board {
                columnElements.append(row[rowCount])
            }
            if allSame(columnElements) {
                return true
            }
        }
        return false
    }
        
    private func checkWinCross() -> Bool {
        var crossMain: [Bool?] = []
        var crossAux: [Bool?] = []
        var crossCount = 0
        for row in board {
            crossMain.append(row[crossCount])
            crossAux.append(row[board.count - 1 - crossCount])
            crossCount += 1
        }
        return allSame(crossMain) || allSame(crossAux)
    }
}
