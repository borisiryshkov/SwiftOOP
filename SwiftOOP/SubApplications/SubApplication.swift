enum SubApplicationAction {
    case resume
    case quit
}

class SubApplication {
    let command: String
    let description: String
    let message: String
    
    init(command: String, description: String, message: String) {
        self.command = command
        self.description = description
        self.message = message
    }
    
    func applicationMenu() {
        print(message)
        while true {
            let action = runMenu()
            if action == .quit {
                return
            }
        }
    }
    
    func runMenu() -> SubApplicationAction {
        .resume
    }
}
