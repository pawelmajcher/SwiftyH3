
import Ch3

public extension H3Indexable {
    /// The resolution of the cell associated with this index.
    var resolution: H3Cell.Resolution {
        get throws(SwiftyH3Error) {
            guard
                let resolutionValue = H3Cell.Resolution(rawValue: Ch3.getResolution(self.id))
            else { throw SwiftyH3Error.returnedInvalidValue }

            return resolutionValue
        }
    }
}

public extension H3Indexable {
    /// The base cell number of the H3 index.
    var baseCellNumber: Int32 {
        return Ch3.getBaseCellNumber(self.id)
    }
}

public extension H3Indexable {
    /// Returns an indexing digit for a given resolution from 1 to 15
    /// or ``baseCellNumber`` for ``H3Cell.Resolution.res0``.
    func digit(for resolution: H3Cell.Resolution) throws(SwiftyH3Error) -> Int32 {
        guard resolution != .res0 else { return baseCellNumber }

        var indexingDigit: Int32 = -1
        let h3error = Ch3.getIndexDigit(self.id, resolution.rawValue, &indexingDigit)

        guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }
        guard indexingDigit != -1 else { throw SwiftyH3Error.returnedInvalidValue }

        return indexingDigit
    }
}

