
import Ch3

public extension H3DirectedEdge {
    var isValid: Bool {
        return Ch3.isValidDirectedEdge(self.id) != 0
    }
}