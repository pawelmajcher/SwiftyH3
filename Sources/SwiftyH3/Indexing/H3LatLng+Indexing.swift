
import Ch3

public extension H3LatLng {
    func cell(at resolution: H3CellResolution) throws -> H3Cell {
        var cLatLng = Ch3.LatLng(from: self)
        var cellIndex: UInt64 = 0

        let h3error = Ch3.latLngToCell(&cLatLng, resolution.rawValue, &cellIndex)

        guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }
        guard cellIndex != 0 else { throw SwiftyH3Error.returnedInvalidValue }

        return H3Cell(cellIndex)
    }
}