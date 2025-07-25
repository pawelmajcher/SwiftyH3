
import Ch3

public extension H3Cell {
    /// Array of all resolution 0 cells.
    static var res0Cells: [H3Cell] {
        get throws(SwiftyH3Error) {
            let res0CellCount = 122

            var indexArray = Array<UInt64>(repeating: 0, count: res0CellCount)
            let h3error = indexArray.withUnsafeMutableBufferPointer { buffer in
                Ch3.getRes0Cells(buffer.baseAddress)
            }

            guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }

            return indexArray.map { index in H3Cell(index) }
        }
    }
}