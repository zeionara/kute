import XCTest
@testable import kute

final class kuteTests: XCTestCase {
    // func testExample() throws {
    //     // This is an example of a functional test case.
    //     // Use XCTAssert and related functions to verify your tests produce the correct
    //     // results.
    //     XCTAssertEqual(kute().text, "Hello, World!")
    // }

    func testSeeds() throws {
        // let word = "kute"

        // print(String.commonSyllables)

        // for seed in 17..<18 {
        //     String.seed = seed
        //     let token = String.token

        //     if token.starts(with: "k") {
        //         print("The system generates word \(token) with seed \(seed)")
        //         break
        //     }
        // }

        String.seed = 17
        XCTAssertEqual(String.token, "kute")
    }
}
