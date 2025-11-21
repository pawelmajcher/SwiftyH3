
import Ch3

public extension H3Indexable {
    /// `true` if this is a valid H3 index and `false` otherwise.
    /// 
    /// > Note: This will return `true` even if most functions will throw due to a type
    /// mismatch, for example if the value of the index is a representation of a directed edge,
    /// and the defined structure is an ``H3Cell``. In most cases you will want to use ``isValid``
    /// to check validity for a given type instead.
    var isSomeH3Index: Bool {
        return Ch3.isValidIndex(self.id) != 0
    }
}

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
    /// Returns an indexing digit for a given resolution.
    /// 
    /// - Returns: A 0–6 value for used index digits from 1 to 15 and
    /// ``baseCellNumber`` for ``H3Cell/Resolution/res0``.
    ///
    /// In valid indexes, this function returns an unused index digit (`7`)
    /// for resolutions finer than ``resolution``.
    func digit(for resolution: H3Cell.Resolution) throws(SwiftyH3Error) -> Int32 {
        guard resolution != .res0 else { return baseCellNumber }

        var indexingDigit: Int32 = -1
        let h3error = Ch3.getIndexDigit(self.id, resolution.rawValue, &indexingDigit)

        guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }
        guard indexingDigit != -1 else { throw SwiftyH3Error.returnedInvalidValue }

        return indexingDigit
    }
}

