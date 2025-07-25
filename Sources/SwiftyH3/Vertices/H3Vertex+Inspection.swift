
import Ch3

public extension H3Vertex {
    /// `true` if the index represents a valid vertex and `false` otherwise.
    var isValid: Bool {
        return Ch3.isValidVertex(self.id) != 0
    }
}