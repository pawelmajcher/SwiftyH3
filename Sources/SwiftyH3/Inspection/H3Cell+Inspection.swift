
import Ch3

extension H3Cell {
    var isValid: Bool {
        return Ch3.isValidCell(self.id) != 0
    }
    
    var isResClassIII: Bool {
        return Ch3.isResClassIII(self.id) != 0
    }

    var isPentagon: Bool {
        return Ch3.isPentagon(self.id) != 0
    }
}