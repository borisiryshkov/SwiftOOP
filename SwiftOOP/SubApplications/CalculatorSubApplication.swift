class CalculatorSubApplication: SubApplication {
    override var command: String { "c" }
    override var description: String { "Launch the Calculator" }
    
    private var state: Bool = true

    private var firstNumber: Double?
    private var secondNumber: Double?

    private var history: [String] = []
    
    override func run() {
        print("Welcome to calculator!")
        while true {
            print("For calculation, enter 'c'. For history, enter 'h'. For exit, enter 'q'.")
            let operation = readLine() ?? "?"
            switch operation {
            case "c":
                calculation()
            case "h":
                for item in history {
                    print(item)
                }
                continue
            case "q":
                return
            default:
                print("Input error - input should be one of: 'c', 'h' or 'q'")
                print("\n-----------------------------------------------------------\n")
                continue
            }
        }
    }

    private func inputNumbers() {
        let event = state ? "first" : "second"
        print("Input \(event) integer")
        while let input = readLine() {
            guard let value = Int(input) else {
                print("Input error - enter an integer")
                continue
            }
            let number = Double(value)
            if state {
                firstNumber = number
            } else {
                secondNumber = number
            }
            state.toggle()
            break
        }
    }

    private func calculation() {
        while true {
            print("Select operation: +, -, *, /. For back to the menu, enter 'b'")
            let operation = readLine() ?? "?"
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
