
import Ch3

public extension H3CellResolution {
    /// All pentagon cells for the resolution.
    var pentagons: [H3Cell] {
        get throws {
            let pentagonCount = 12

            let indexArray = try Array<UInt64>(unsafeUninitializedCapacity: pentagonCount) { buffer, initializedCount in
                let h3error = Ch3.getPentagons(self.rawValue, buffer.baseAddress)

                guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }

                initializedCount = pentagonCount
            }

            return indexArray.map { index in H3Cell(index) }
        }
    }
}