import ArgumentParser

struct Serve: ParsableCommand {
    // @Flag(help: "Include a counter with each repetition.")
    // var includeCounter = false

    @Option(name: .shortAndLong, help: "The port to run server on")
    var port: Int = 8080

    // @Argument(help: "The phrase to repeat.")
    // var phrase: String

    mutating func run() throws {
        print("Starting kute server on port \(port)...")

        // let repeatCount = count ?? 2

        // for i in 1...repeatCount {
        //     if includeCounter {
        //         print("\(i): \(phrase)")
        //     } else {
        //         print(phrase)
        //     }
        // }
    }
}

@main
struct Kute: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "A tiny http event tracker",
        version: "0.0.1",
        subcommands: [Serve.self]
    )
}

// @main
// public struct kute {
//     public private(set) var text = "Hello, World!"
// 
//     public static func main() {
//         print(kute().text)
//     }
// }
