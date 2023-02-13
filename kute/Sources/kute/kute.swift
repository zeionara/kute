import Foundation
import ArgumentParser
import Swifter

struct Serve: ParsableCommand {

    @Option(name: .shortAndLong, help: "The port to run server on")
    var port: UInt16 = 8080

    @Option(name: .shortAndLong, help: "Check interval")
    var checkInterval: UInt32 = 10  // how many seconds to wait before making sure that the server is still running

    mutating func run() throws {
        let server = HttpServer()

        // let dir = try FileManager.default.currentDirectoryPath

        server["/default"] = { (foo: HttpRequest) -> HttpResponse in

            if let prefix = ProcessInfo.processInfo.environment["TOKEN_PREFIX"] {
                return .ok(
                    .json(
                        [
                            "date": "\(prefix)-\(Date().token)",
                            "word": "\(prefix)-\(String.token)",
                            "uuid": "\(prefix)-\(UUID().uuidString.lowercased())"
                        ]
                    )
                )
            }

            return .ok(
                .json(
                    [
                        "date": Date().token,
                        "word": String.token,
                        "uuid": UUID().uuidString.lowercased()
                    ]
                )
            )
        }

        print("Started kute server on port \(port)...")

        try server.start(port)

        while server.state == .running {
            sleep(checkInterval)
        }

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
