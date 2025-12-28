class Application {
    private let subApplications = [
        CalculatorSubApplication(),
        NoughtsAndCrossesSubApplication(),
        ExitSubApplication()
    ]
    
    func run() {
        print("Welcome to the application!")
        while true {
            let action = getAction()
            for subApplication in subApplications {
                if subApplication.command == action {
                    subApplication.run()
                    break
                }
            }
        }
    }
    
    private func getAction() -> String {
        var description = "Choose an option:"
        for subApplication in subApplications {
            description += "\n\t\(subApplication.command) - \(subApplication.description)"
        }
        return getDataFromUser(description: description)
    }
}

func getDataFromUser(description: String) -> String {
    print(description)
    return readLine() ?? ""
}
