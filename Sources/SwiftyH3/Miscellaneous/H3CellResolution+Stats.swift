
import Foundation
import Ch3

public extension H3CellResolution {
    var averageHexagonArea: Measurement<UnitArea> {
        get throws {
            var areaM2: Double = 0
            let h3error = Ch3.getHexagonAreaAvgM2(self.rawValue, &areaM2)

            guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }
            guard areaM2 != 0 else { throw SwiftyH3Error.returnedInvalidValue }

            return Measurement(value: areaM2, unit: .squareMeters)
        }
    }

    var averageHexagonEdgeLength: Measurement<UnitLength> {
        get throws {
            var lengthM: Double = 0
            let h3error = Ch3.getHexagonEdgeLengthAvgM(self.rawValue, &lengthM)

            guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }
            guard lengthM != 0 else { throw SwiftyH3Error.returnedInvalidValue }

            return Measurement(value: lengthM, unit: .meters)
        }
    }

    var numberOfCells: Int64 {
        get throws {
            var cellCount: Int64 = 0
            let h3error = Ch3.getNumCells(self.rawValue, &cellCount)

            guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }
            guard cellCount != 0 else { throw SwiftyH3Error.returnedInvalidValue }

            return cellCount
        }
    }
}

