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
                    subApplication.applicationMenu()
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
        return UserDataProvider.enterString(description)
    }
}
