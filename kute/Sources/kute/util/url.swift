import Foundation


public extension URL {
    static var currentDirectory: Self {
        return Self(fileURLWithPath: FileManager.default.currentDirectoryPath)
    }

    static var assets: Self {
        return self.currentDirectory.appendingPathComponent("Assets")
    }

    static var commonSyllables: Self {
        return self.assets.appendingPathComponent("common-syllables.txt")
    }

    static var registrySnapshot: Self {
        return self.assets.appendingPathComponent("registry-snapshot.json")
    }
}
