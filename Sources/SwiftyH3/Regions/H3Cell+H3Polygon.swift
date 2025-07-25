
import Ch3

public extension Sequence<H3Cell> {
    /// The multipolygon representing the given set of cells.
    var multiPolygon: H3MultiPolygon {
        get throws(SwiftyH3Error) {
            guard self.allSatisfy({ $0.isValid }) else { throw SwiftyH3Error.invalidInput }

            var linkedGeoPolygon = Ch3.LinkedGeoPolygon()
            defer { withUnsafeMutablePointer(to: &linkedGeoPolygon) { pointer in Ch3.destroyLinkedMultiPolygon(pointer) } }

            let indexArray = self.map { cell in cell.id }

            let h3error = indexArray.withUnsafeBufferPointer { buffer in
                Ch3.cellsToLinkedMultiPolygon(buffer.baseAddress, Int32(buffer.count), &linkedGeoPolygon)
            }

            guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }

            // Convert linked structures to Swift types
            return withUnsafeMutablePointer(to: &linkedGeoPolygon) { ptr in
                H3MultiPolygon.extract(from: ptr)
            }
        }
    }
}

public extension H3MultiPolygon {
    init?(from h3cells: [H3Cell]) {
        guard let multiPolygon = try? h3cells.multiPolygon else { return nil }
        self = multiPolygon
    }
}