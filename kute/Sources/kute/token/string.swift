import Foundation


public extension String {
    static let tokenLength: Int = 3
    static let commonSyllables = try! String(contentsOf: URL.commonSyllables).components(separatedBy: "\n")

    // static let vowels = ["a", "e", "i", "o", "u", "y"]

    static var token: String {
        (0..<String.tokenLength).map{ _ in
            String.commonSyllables.randomElement()!
        }.joined(separator: "")
    }
}
