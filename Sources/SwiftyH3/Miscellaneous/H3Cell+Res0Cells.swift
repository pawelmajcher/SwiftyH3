
import Ch3

public extension H3Cell {
    static var res0Cells: [H3Cell] {
        get throws {
            let res0CellCount = 122

            let indexArray = try Array<UInt64>(unsafeUninitializedCapacity: res0CellCount) { buffer, initializedCount in
                let h3error = Ch3.getRes0Cells(buffer.baseAddress)

                guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }

                initializedCount = res0CellCount
            }

            return indexArray.map { index in H3Cell(index) }
        }
    }
}