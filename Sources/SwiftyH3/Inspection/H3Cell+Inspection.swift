
import Ch3

public extension H3Cell {
    /// `true` if the index represents a valid cell and `false` otherwise.
    var isValid: Bool {
        return Ch3.isValidCell(self.id) != 0
    }
    
    /// `true` if this cell has a resolution with Class III orientation and `false` otherwise.
    var isResClassIII: Bool {
        return Ch3.isResClassIII(self.id) != 0
    }

    /// `true` if this is a pentagonal cell and `false` otherwise.
    var isPentagon: Bool {
        return Ch3.isPentagon(self.id) != 0
    }
}