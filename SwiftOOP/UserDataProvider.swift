class UserDataProvider {
    static func enterString(_ description: String) -> String {
        print(description)
        while let input = readLine() {
            guard input != "" else {
                print("Please enter a text")
                continue
            }
            return input
        }
        return "Unknown"
    }
    
    static func enterInteger(_ description: String, targetVar: inout Int) {
        print(description)
        while let input = readLine() {
            guard let inputInt = Int(input) else {
                print("Please enter a valid integer value")
                continue
            }
            targetVar = inputInt
            break
        }
    }
}
