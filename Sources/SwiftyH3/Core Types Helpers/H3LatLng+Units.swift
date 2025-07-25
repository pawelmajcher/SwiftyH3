
import Foundation

public extension H3LatLng {
    var latitude: Measurement<UnitAngle> { Measurement(value: latitudeRads, unit: .radians) }
    var longitude: Measurement<UnitAngle> { Measurement(value: longitudeRads, unit: .radians) }

    // Latitude in degrees.
    var latitudeDegs: Double { self.latitude.converted(to: .degrees).value }

    // Longitude in degrees.
    var longitudeDegs: Double { self.longitude.converted(to: .degrees).value }
}

public extension H3LatLng {
    init(latitudeDegs: Double, longitudeDegs: Double) {
        self.latitudeRads = Measurement<UnitAngle>(value: latitudeDegs, unit: .degrees).converted(to: .radians).value
        self.longitudeRads = Measurement<UnitAngle>(value: longitudeDegs, unit: .degrees).converted(to: .radians).value
    }
}