
import Foundation
import Ch3

public extension H3DirectedEdge {
    var length: Measurement<UnitLength> {
        get throws {
            guard self.isValid else { throw SwiftyH3Error.invalidInput }

            var lengthM: Double = 0
            let h3error = Ch3.edgeLengthM(self.id, &lengthM)

            guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }
            guard lengthM != 0 else { throw SwiftyH3Error.returnedInvalidValue }

            return Measurement(value: lengthM, unit: .meters)
        }
    }

    var lengthRads: Measurement<UnitAngle> {
        get throws {
            guard self.isValid else { throw SwiftyH3Error.invalidInput }

            var lengthRads: Double = 0
            let h3error = Ch3.edgeLengthRads(self.id, &lengthRads)

            guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }
            guard lengthRads != 0 else { throw SwiftyH3Error.returnedInvalidValue }

            return Measurement(value: lengthRads, unit: .radians)
        }
    }
}