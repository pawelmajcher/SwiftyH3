
import Ch3

public extension H3Cell {
    /// `true` if the index represents a valid cell and `false` otherwise.
    var isValid: Bool {
        return Ch3.isValidCell(self.id) != 0
    }
    
    /// `true` if this cell has a resolution with Class III orientation and `false` otherwise.
    var isResClassIII: Bool {
        return Ch3.isResClassIII(self.id) != 0
    }

    /// `true` if this is a pentagonal cell and `false` otherwise.
    var isPentagon: Bool {
        return Ch3.isPentagon(self.id) != 0
    }
}

public extension H3Cell {
    /// Initialize an H3Cell from a base cell and an array of indexing digits.
    /// 
    /// This initializer only allows for constructing valid H3 cells,
    /// and will return an error if the provided components would create
    /// an invalid cell.
    /// 
    /// - Parameter baseCellNumber: Base cell number of the cell. (0–121)
    /// - Parameter digits: An array of indexing digits (0–6). Each element
    ///   `digits[i]` corresponds to the digit at resolution `i+1`. The
    ///   resolution of the cell is defined by the length of this array.
    ///   The default empty array creates a resolution 0 cell.
    /// 
    /// - Throws: ``SwiftyH3Error/H3Error(_:)`` if the provided components
    ///   would not create a valid cell. Note that when constructing a cell
    ///   from a pentagon base cell, digit `1` is
    ///   [not allowed to follow](https://h3geo.org/docs/library/index/cell)
    ///   immediately after a sequence of zeroes.
    init(
        base baseCellNumber: Int32,
        _ digits: [Int32] = []
    ) throws(SwiftyH3Error) {
        var cellId: UInt64 = 0
        let h3error = digits.withUnsafeBufferPointer { pointer in
            Ch3.constructCell(
                Int32(pointer.count),
                baseCellNumber,
                pointer.baseAddress,
                &cellId
            )
        }

        guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }
        guard cellId != 0 else { throw SwiftyH3Error.returnedInvalidValue }

        self.init(cellId)
    }
}