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

    @Flag(name: .shortAndLong, help: "Do not read content of registry from the snapshot file")
    var bare: Bool = false

    mutating func run() throws {
        let server = HttpServer()
        var registry: TokenRegistry

        String.seed = seed

        do { 
            registry = bare ? TokenRegistry() : try TokenRegistry.load(from: URL.registrySnapshot)
        } catch {
            registry = TokenRegistry()
        }

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
                    Token(in: &registry).asDict(prefix: prefix, suffix: suffix)
                )
            )
        }

        let decoder = JSONDecoder()
        let encoder = JSONEncoder()

        server["/find"] = { (foo: HttpRequest) -> HttpResponse in
            // print(foo.body)

            if let request = try? decoder.decode(WordRequest.self, from: Data(foo.body)) {
                let response: TokensResponse

                if let tokens = registry.get(word: String(request.word.dropFirst(prefix.count).dropLast(suffix.count))) {
                    response = TokensResponse(
                        found: true,
                        items: tokens.map{ token in
                            token.asDict(prefix: prefix, suffix: suffix)
                        }
                    )
                } else {
                    response = TokensResponse(
                        found: false
                    )
                }

                return .ok(
                    try! .data(encoder.encode(response))
                )
            } else if let request = try? decoder.decode(DateRequest.self, from: Data(foo.body)) {
                let response: TokensResponse

                if let tokens = registry.get(date: String(request.date.dropFirst(prefix.count).dropLast(suffix.count))) {
                    response = TokensResponse(
                        found: true,
                        items: tokens.map{ token in
                            token.asDict(prefix: prefix, suffix: suffix)
                        }
                    )
                } else {
                    response = TokensResponse(
                        found: false
                    )
                }

                return .ok(
                    try! .data(encoder.encode(response))
                )
            }

            return .badRequest(nil)
        }

        server["dump"] = { (request: HttpRequest) -> HttpResponse in
            return .ok(
                try! .data(
                    encoder.encode(registry)
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
