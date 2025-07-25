
import Ch3

public extension H3DirectedEdge {
    /// The origin cell of the edge.
    var origin: H3Cell {
        get throws(SwiftyH3Error) {
            guard self.isValid else { throw SwiftyH3Error.invalidInput }

            var originId: UInt64 = 0
            let h3error = Ch3.getDirectedEdgeOrigin(self.id, &originId)

            guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }
            guard originId != 0 else { throw SwiftyH3Error.returnedInvalidValue }

            return H3Cell(originId)
        }
    }

    /// The destination cell of the edge.
    var destination: H3Cell {
        get throws(SwiftyH3Error) {
            guard self.isValid else { throw SwiftyH3Error.invalidInput }
            
            var destinationId: UInt64 = 0
            let h3error = Ch3.getDirectedEdgeDestination(self.id, &destinationId)

            guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }
            guard destinationId != 0 else { throw SwiftyH3Error.returnedInvalidValue }

            return H3Cell(destinationId)
        }
    }
}