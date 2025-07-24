
import Ch3

extension H3Indexable {
    var resolution: H3CellResolution {
        get throws {
            guard
                let resolutionValue = H3CellResolution(rawValue: Ch3.getResolution(self.id))
            else { throw SwiftyH3Error.returnedInvalidValue }

            return resolutionValue
        }
    }
}

extension H3Indexable {
    var baseCellNumber: Int32 {
        return Ch3.getBaseCellNumber(self.id)
    }
}

