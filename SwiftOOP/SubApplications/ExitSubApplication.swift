import Darwin

class ExitSubApplication: SubApplication {
    override var command: String { "q" }
    override var description: String { "Exit the application" }
    
    override func run() {
        exit(0)
    }
}
