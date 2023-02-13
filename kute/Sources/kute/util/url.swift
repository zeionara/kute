import Foundation


public extension URL {
    static var currentDirectory: URL {
        return URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
    }

    static var assets: URL {
        return self.currentDirectory.appendingPathComponent("Assets")
    }

    static var commonSyllables: URL {
        return self.assets.appendingPathComponent("common-syllables.txt")
    }
}
