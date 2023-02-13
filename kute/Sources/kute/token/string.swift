import Foundation


public extension String {
    static let tokenLength: Int = 2
    static let commonSyllables = try! String(contentsOf: URL.commonSyllables).components(separatedBy: "\n")

    private static var seedValue: Int?
    private static var generator: RandomNumberGeneratorWithSeed?

    // static let vowels = ["a", "e", "i", "o", "u", "y"]

    static var seed: Int? {
        get {
            return seedValue
        }
        set {
            if let seed = newValue {
                seedValue = seed
                generator = RandomNumberGeneratorWithSeed(seed: seed)
            }
        }
    }

    static var token: String {
        if var generator = generator {
            // var foo = RandomNumberGeneratorWithSeed(seed: 17)
            return (0..<String.tokenLength).map{ _ in
                String.commonSyllables.randomElement(using: &generator)
            }.joined(separator: "")
        }

        return (0..<String.tokenLength).map{ _ in
            String.commonSyllables.randomElement()!
        }.joined(separator: "")
    }
}
