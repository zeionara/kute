public extension Array {
    func randomElement<T> (using generator: inout T) -> Self.Element where T: RandomNumberGenerator {
        // let index = Int.random(in: 0..<self.count, using: &generator)
        let index: Int = Int(generator.next() % UInt64(self.count))
        // print(index)
        return self[index]
    }
}
