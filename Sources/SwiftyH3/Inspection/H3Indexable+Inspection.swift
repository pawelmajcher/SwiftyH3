
import Ch3

public extension H3Indexable {
    /// The resolution of the cell associated with this index.
    var resolution: H3CellResolution {
        get throws(SwiftyH3Error) {
            guard
                let resolutionValue = H3CellResolution(rawValue: Ch3.getResolution(self.id))
            else { throw SwiftyH3Error.returnedInvalidValue }

            return resolutionValue
        }
    }
}

public extension H3Indexable {
    /// The base cell number of the index.
    var baseCellNumber: Int32 {
        return Ch3.getBaseCellNumber(self.id)
    }
}

