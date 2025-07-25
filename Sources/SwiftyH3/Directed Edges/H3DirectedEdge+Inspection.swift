
import Ch3

public extension H3DirectedEdge {
    /// `true` if the index represents a valid directed edge and `false` otherwise.
    var isValid: Bool {
        return Ch3.isValidDirectedEdge(self.id) != 0
    }
}