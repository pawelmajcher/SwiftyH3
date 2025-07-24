
import Ch3

public extension H3Cell {
    func isNeighbor(of anotherCell: H3Cell) throws -> Bool {
        guard self.isValid else { throw SwiftyH3Error.invalidInput }
        guard anotherCell.isValid else { throw SwiftyH3Error.invalidInput }

        var isNeighborInt: Int32 = -1
        let h3error = Ch3.areNeighborCells(self.id, anotherCell.id, &isNeighborInt)

        guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }
        guard isNeighborInt != -1 else { throw SwiftyH3Error.returnedInvalidValue }

        return isNeighborInt != 0
    }
}