
import Ch3

public extension H3CellResolution {
    /// All pentagon cells for the resolution.
    var pentagons: [H3Cell] {
        get throws(SwiftyH3Error) {
            let pentagonCount = 12

            var indexArray = Array<UInt64>(repeating: 0, count: pentagonCount)
            let h3error = indexArray.withUnsafeMutableBufferPointer { buffer in
                Ch3.getPentagons(self.rawValue, buffer.baseAddress)
            }

            guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }

            return indexArray.map { index in H3Cell(index) }
        }
    }
}