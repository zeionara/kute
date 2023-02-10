import Foundation
import ArgumentParser
import Swifter

struct Serve: ParsableCommand {
    // @Flag(help: "Include a counter with each repetition.")
    // var includeCounter = false

    @Option(name: .shortAndLong, help: "The port to run server on")
    var port: UInt16 = 8080

    @Option(name: .shortAndLong, help: "Check interval")
    var checkInterval: UInt32 = 10  // how many seconds to wait before making sure that the server is still running

    // @Argument(help: "The phrase to repeat.")
    // var phrase: String

    mutating func run() throws {
        let server = HttpServer()

        server["/default"] = { (foo: HttpRequest) -> HttpResponse in

            let date = Date()
            let components = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute, .second, .nanosecond], from: date)
            let stringifiedDate = "\(String(format: "%02d", components.day!))-\(String(format: "%02d", components.month!))-\(components.year!)-\(String(format: "%02d", components.hour!)):\(String(format: "%02d", components.minute!)):\(String(format: "%02d", components.second!)).\(String(components.nanosecond!).prefix(2))"

            if let prefix = ProcessInfo.processInfo.environment["TOKEN_PREFIX"] {
                return .ok(
                    .json(
                        [
                            "token": "\(prefix)-\(stringifiedDate)"
                        ]
                    )
                )
            }

            return .ok(
                .json(
                    [
                        "token": stringifiedDate
                    ]
                )
            )
        }

        print("Starting kute server on port \(port)...")


        try server.start(port)

        while server.state == .running {
            sleep(checkInterval)
        }

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
