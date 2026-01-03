import Darwin

class ExitSubApplication: SubApplication {
    init() {
        super.init(
            command: "q",
            description: "Exit the application",
            message: "Goodbye!"
        )
    }
    
    override func runMenu() -> SubApplicationAction {
        exit(0)
    }
}
