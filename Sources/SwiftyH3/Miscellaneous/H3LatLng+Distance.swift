
import Foundation
import Ch3

public extension H3LatLng {
    /// The distance between two coordinates as a measurement value (in meters).
    func distance(to destination: H3LatLng) -> Measurement<UnitLength> {
        let distanceM: Double = withUnsafePointer(to: self.cLatLng) { pOrigin in
            withUnsafePointer(to: destination.cLatLng) { pDestination in
                Ch3.greatCircleDistanceM(pOrigin, pDestination)
            }
        }

        return Measurement(value: distanceM, unit: .meters)
    }

    /// The distance between two coordinates as a measurement value (in radians).
    func distanceRads(to destination: H3LatLng) -> Measurement<UnitAngle> {
        let distanceRads: Double = withUnsafePointer(to: self.cLatLng) { pOrigin in
            withUnsafePointer(to: destination.cLatLng) { pDestination in
                Ch3.greatCircleDistanceRads(pOrigin, pDestination)
            }
        }

        return Measurement(value: distanceRads, unit: .radians)
    }
}