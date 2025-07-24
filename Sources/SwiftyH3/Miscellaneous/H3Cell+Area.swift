
import Foundation
import Ch3

extension H3Cell {
    var area: Measurement<UnitArea> {
        get throws {
            guard self.isValid else { throw SwiftyH3Error.invalidInput }

            var areaM2: Double = 0
            let h3error = Ch3.cellAreaM2(self.id, &areaM2)

            guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }
            guard areaM2 != 0 else { throw SwiftyH3Error.returnedInvalidValue }

            return Measurement(value: areaM2, unit: .squareMeters)
        }
    }

    var areaRads2: Double {
        get throws {
            guard self.isValid else { throw SwiftyH3Error.invalidInput }
            
            var areaRads2: Double = 0
            let h3error = Ch3.cellAreaRads2(self.id, &areaRads2)

            guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }
            guard areaRads2 != 0 else { throw SwiftyH3Error.returnedInvalidValue }

            return areaRads2
        }
    }
}