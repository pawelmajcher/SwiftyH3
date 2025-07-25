
import Ch3

public extension H3Cell {
    /// A directed edge from the cell to another neighboring cell.
    func directedEdge(to destination: H3Cell) throws -> H3DirectedEdge {
        guard self.isValid else { throw SwiftyH3Error.invalidInput }
        guard destination.isValid else { throw SwiftyH3Error.invalidInput }

        var edgeId: UInt64 = 0
        let h3error = Ch3.cellsToDirectedEdge(self.id, destination.id, &edgeId)

        guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }
        guard edgeId != 0 else { throw SwiftyH3Error.returnedInvalidValue }

        return H3DirectedEdge(edgeId)
    }
}

public extension H3DirectedEdge {
    /// An optional initializer for a directed edge from one cell to another.
    /// 
    /// Returns `nil` if the cells are not neighboring cells.
    init?(origin: H3Cell, destination: H3Cell) {
        guard let edge = try? origin.directedEdge(to: destination) else { return nil }
        self = edge
    }
}

public extension H3Cell {
    /// An array of all directed edges starting from the cell.
    var directedEdges: [H3DirectedEdge] {
        get throws {
            guard self.isValid else { throw SwiftyH3Error.invalidInput }

            let numberOfEdges = 6
            let edgeIds = try Array<UInt64>(unsafeUninitializedCapacity: numberOfEdges) { buffer, initializedCount in
                let h3error = Ch3.originToDirectedEdges(self.id, buffer.baseAddress)
                initializedCount = numberOfEdges

                guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }
            }

            return edgeIds.filter { edgeId in edgeId != 0 }.map { edgeId in H3DirectedEdge(edgeId) }
        }
    }
}