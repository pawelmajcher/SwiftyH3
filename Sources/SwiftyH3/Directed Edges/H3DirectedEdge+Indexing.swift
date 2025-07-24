
import Ch3

public extension H3DirectedEdge {
    var boundary: [H3LatLng] {
        get throws {
            guard self.isValid else { throw SwiftyH3Error.invalidInput }

            var cBoundary = Ch3.CellBoundary()
            let h3error = Ch3.directedEdgeToBoundary(self.id, &cBoundary)

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