import Foundation
import ArgumentParser
import Swifter

struct Serve: ParsableCommand {

    @Option(name: .shortAndLong, help: "The port to run server on")
    var port: UInt16 = 8080

    @Option(name: .shortAndLong, help: "Check interval")
    var checkInterval: UInt32 = 10  // how many seconds to wait before making sure that the server is still running

    @Option(name: .shortAndLong, help: "Seed for generating randomized tokens")
    var seed: Int?

    mutating func run() throws {
        let server = HttpServer()

        String.seed = seed

        // let dir = try FileManager.default.currentDirectoryPath
        let prefix: String
        let suffix: String

        if let envPrefix = ProcessInfo.processInfo.environment["TOKEN_PREFIX"] {
            prefix = "\(envPrefix)-"
        } else {
            prefix = "" 
        }

        if let envSuffix = ProcessInfo.processInfo.environment["TOKEN_SUFFIX"] {
            suffix = "-\(envSuffix)"
        } else {
            suffix = "" 
        }

        server["/"] = { (foo: HttpRequest) -> HttpResponse in
            return .ok(
                .json(
                    [
                        "date": "\(prefix)\(Date().token)\(suffix)",
                        "word": "\(prefix)\(String.token)\(suffix)",
                        "uuid": "\(prefix)\(UUID().uuidString.lowercased())\(suffix)"
                    ]
                )
            )
        }

        print("Started kute server on port \(port)")
        print("Try running the following command:\n\ncurl localhost:\(port)")

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
