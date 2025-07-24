
import Foundation
import Ch3

extension H3LatLng {
    func distance(to destination: H3LatLng) -> Measurement<UnitLength> {
        let distanceM: Double = withUnsafePointer(to: self.cLatLng) { pOrigin in
            withUnsafePointer(to: destination.cLatLng) { pDestination in
                Ch3.greatCircleDistanceM(pOrigin, pDestination)
            }
        }

        return Measurement(value: distanceM, unit: .meters)
    }

    func distanceRads(to destination: H3LatLng) -> Measurement<UnitAngle> {
        let distanceRads: Double = withUnsafePointer(to: self.cLatLng) { pOrigin in
            withUnsafePointer(to: destination.cLatLng) { pDestination in
                Ch3.greatCircleDistanceRads(pOrigin, pDestination)
            }
        }

        return Measurement(value: distanceRads, unit: .radians)
    }
}