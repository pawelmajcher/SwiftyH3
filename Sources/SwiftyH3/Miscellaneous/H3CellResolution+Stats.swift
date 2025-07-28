
import Foundation
import Ch3

public extension H3Cell.Resolution {
    /// An average area of a hexagon having the resolution.
    var averageHexagonArea: Measurement<UnitArea> {
        get {
            do throws(SwiftyH3Error) {
                var areaM2: Double = 0
                let h3error = Ch3.getHexagonAreaAvgM2(self.rawValue, &areaM2)

                guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }
                guard areaM2 != 0 else { throw SwiftyH3Error.returnedInvalidValue }

                return Measurement(value: areaM2, unit: .squareMeters)
            } catch {
                fatalError(error.errorDescription ?? error.localizedDescription)
            }
            
        }
    }

    /// An average edge length of a hexagon having the resolution.
    var averageHexagonEdgeLength: Measurement<UnitLength> {
        get {
            do throws(SwiftyH3Error) {
                var lengthM: Double = 0
                let h3error = Ch3.getHexagonEdgeLengthAvgM(self.rawValue, &lengthM)

                guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }
                guard lengthM != 0 else { throw SwiftyH3Error.returnedInvalidValue }

                return Measurement(value: lengthM, unit: .meters)
            } catch {
                fatalError(error.errorDescription ?? error.localizedDescription)
            }
        }
    }

    /// The total number of cells having the resolution.
    var numberOfCells: Int64 {
        get {
            do throws(SwiftyH3Error) {
                var cellCount: Int64 = 0
                let h3error = Ch3.getNumCells(self.rawValue, &cellCount)

                guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }
                guard cellCount != 0 else { throw SwiftyH3Error.returnedInvalidValue }

                return cellCount
            } catch {
                fatalError(error.errorDescription ?? error.localizedDescription)
            }
        }
    }
}

