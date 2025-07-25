
import Ch3

public extension H3Cell {
    /// The coordinates for the center of the cell.
    var center: H3LatLng {
        get throws(SwiftyH3Error) {
            guard self.isValid else { throw SwiftyH3Error.invalidInput }

            var cLatLng = Ch3.LatLng(lat: 0, lng: 0)
            let h3error = Ch3.cellToLatLng(self.id, &cLatLng)

            guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }

            return H3LatLng(from: cLatLng)
        }
    }

    /// An array of locations of the cell's vertices, joinly representing an `H3Loop` (linear ring).
    var boundary: H3Loop {
        get throws(SwiftyH3Error) {
            guard self.isValid else { throw SwiftyH3Error.invalidInput }

            var cBoundary = Ch3.CellBoundary()
            let h3error = Ch3.cellToBoundary(self.id, &cBoundary)

            guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }

            let verticesCount = Int(cBoundary.numVerts)

            let cVertices: [Ch3.LatLng] = withUnsafeBytes(of: &cBoundary.verts) { rawBuffer in
                let buffer = rawBuffer.bindMemory(to: Ch3.LatLng.self)
                return Array(buffer.prefix(verticesCount))
            }

            return cVertices.map { cLatLng in H3LatLng(from: cLatLng) }
        }
    }
}