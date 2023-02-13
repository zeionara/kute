import Foundation


struct Token {
    let uuid: String
    let word: String
    let date: String

    init(in registry: inout TokenRegistry) {
        date = Date().token
        word = String.token
        uuid = UUID().uuidString.lowercased()

        registry.register(token: self)
    }

    init(date: String, word: String, uuid: String) {
        self.date = date
        self.word = word
        self.uuid = uuid
    }

    func asDict(prefix: String, suffix: String) -> [String: String] {
        return [
            "date": "\(prefix)\(date)\(suffix)",
            "word": "\(prefix)\(word)\(suffix)",
            "uuid": "\(prefix)\(uuid)\(suffix)"
        ]
    }
}

struct DateRequest: Codable {
    let date: String
}

struct WordRequest: Codable {
    let word: String
}

struct TokensResponse: Codable {
    let found: Bool
    var items: [[String: String]]? = nil
}

class TokenRegistry: Codable {

    private static let undefined = "undefined"

    private var wordToUuids: [String: [String]]
    private var dateToUuids: [String: [String]]

    private var uuidToWord: [String: String]
    private var uuidToDate: [String: String]

    init() {
        wordToUuids = [String: [String]]()
        dateToUuids = [String: [String]]()

        uuidToWord = [String: String]()
        uuidToDate = [String: String]()
    }

    func register(token: Token) {
        uuidToWord[token.uuid] = token.word
        uuidToDate[token.uuid] = token.date

        if var uuids = wordToUuids[token.word] {
            uuids.append(token.uuid)
            wordToUuids[token.word] = uuids
        } else {
            wordToUuids[token.word] = [token.uuid]
        }

        if var uuids = dateToUuids[token.date] {
            uuids.append(token.uuid)
            dateToUuids[token.date] = uuids
        } else {
            dateToUuids[token.date] = [token.uuid]
        }

        do {
            try save(as: URL.registrySnapshot)
        } catch {
            print("Cannot save registry snapshot as {URL.registrySnapshot}")
        }
    }

    func get(word: String) -> [Token]? {
        print(wordToUuids)
        if let uuids = wordToUuids[word] {
            return uuids.map{ uuid in
                Token(
                    date: uuidToDate[uuid] ?? Self.undefined,
                    word: word,
                    uuid: uuid
                )
            }
        }

        return nil
    }

    func get(date: String) -> [Token]? {
        if let uuids = dateToUuids[date] {
            return uuids.map{ uuid in
                Token(
                    date: date,
                    word: uuidToWord[uuid] ?? Self.undefined,
                    uuid: uuid
                )
            }
        }

        return nil
    }

    func save(as path: URL) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        let data = try encoder.encode(self)
        try String(data: data, encoding: .utf8)!.write(to: path, atomically: false, encoding: .utf8)
    }

    static func load(from path: URL) throws -> Self {
        let decoder = JSONDecoder()

        return try decoder.decode(Self.self, from: Data(contentsOf: path))
    }
}
