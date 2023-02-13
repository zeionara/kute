import Foundation


struct RandomNumberGeneratorWithSeed: RandomNumberGenerator {
    init(seed: Int) {
        // print("Initializing random generator")
        srand48(seed)
    }

    func next() -> UInt64 {
        let generated = drand48()
        return withUnsafeBytes(of: generated) { bytes in
            // print(bytes)
            // let result = bytes.load(as: UInt64.self)
            bytes.load(as: UInt64.self)
            // print(result)
            // return result
        }
    }
}
