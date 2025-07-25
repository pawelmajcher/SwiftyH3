
import Ch3

public extension H3Cell {
    /// Returns `H3Vertex` for the specified vertex number of the cell.
    /// 
    /// - Parameter vertexNumber: The incremental number of the index.
    /// Valid vertex numbers are between 0 and 5 (inclusive) for hexagonal
    /// cells and between 0 and 4 for pentagonal cells.
    /// 
    /// Determine if the cell is pentagonal by `self.isPentagon`.
    func vertex(_ vertexNumber: Int32) throws -> H3Vertex {
        guard self.isValid else { throw SwiftyH3Error.invalidInput }

        var vertexId: UInt64 = 0
        let h3error = Ch3.cellToVertex(self.id, vertexNumber, &vertexId)

        guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }
        guard vertexId != 0 else { throw SwiftyH3Error.returnedInvalidValue }

        return H3Vertex(vertexId)
    }

    /// An array of all vertices of the cell.
    var vertices: [H3Vertex] {
        get throws {
            guard self.isValid else { throw SwiftyH3Error.invalidInput }

            let numberOfVertices = 6
            let vertexIds = try Array<UInt64>(unsafeUninitializedCapacity: numberOfVertices) { buffer, initializedCount in
                let h3error = Ch3.cellToVertexes(self.id, buffer.baseAddress)
                initializedCount = numberOfVertices

                guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }
            }

            return vertexIds.filter { vertexId in vertexId != 0 }.map { vertexId in H3Vertex(vertexId) }
        }
    }
}