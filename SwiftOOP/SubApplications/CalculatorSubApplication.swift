class CalculatorSubApplication: SubApplication {
    init() {
        super.init(
            command: "c",
            description: "Launch the Calculator",
            message: "Welcome to Calculator!"
        )
    }
    
    private var state: Bool = true

    private var firstNumber: Double?
    private var secondNumber: Double?

    private var history: [String] = []
    
    override func runMenu() -> SubApplicationAction {
        let action = UserDataProvider.enterString("For calculation, enter 'c'. For history, enter 'h'. For exit, enter 'q'.")
        switch action {
        case "c":
            calculation()
        case "h":
            for item in history {
                print(item)
            }
        case "q":
            return .quit
        default:
            print("Input error - input should be one of: 'c', 'h' or 'q'")
            print("\n-----------------------------------------------------------\n")
        }
        return .resume
    }

    private func inputNumbers() {
        var value = 0
        let event = state ? "first" : "second"
        UserDataProvider.enterInteger("Input \(event) integer", targetVar: &value)
        let number = Double(value)
        if state {
            firstNumber = number
        } else {
            secondNumber = number
        }
        state.toggle()
    }

    private func calculation() {
        while true {
            let operation = UserDataProvider.enterString("Select operation: +, -, *, /. For back to the menu, enter 'b'")
            switch operation {
            case "+", "-", "*", "/":
                for _ in 0...1 {
                    inputNumbers()
                    guard !(operation == "/" && secondNumber == 0) else {
                        secondNumber = nil
                        print("Zero division error")
                        print("\n-----------------------------------------------------------\n")
                        break
                    }
                }
                var result: Double = 0
                if let firstNumber, let secondNumber {
                    if operation == "+" {
                        result = firstNumber + secondNumber
                    } else if operation == "-" {
                        result = firstNumber - secondNumber
                    } else if operation == "*" {
                        result = firstNumber * secondNumber
                    } else if operation == "/" {
                        result = firstNumber / secondNumber
                    }
                    let example: String = "\(firstNumber) \(operation) \(secondNumber)"
                    history.append(example + " = " + String(result))
                    print("Calculating: \(example)")
                    print("Result: \(result)")
                    print("\n-----------------------------------------------------------\n")
                }
            case "b": return
            default:
                print("Input error - input should be one of: +, -, *, /")
                print("\n-----------------------------------------------------------\n")
            }
        }
    }
}
