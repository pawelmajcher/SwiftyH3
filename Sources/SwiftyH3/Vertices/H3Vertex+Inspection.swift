
import Ch3

extension H3Vertex {
    var isValid: Bool {
        return Ch3.isValidVertex(self.id) != 0
    }
}