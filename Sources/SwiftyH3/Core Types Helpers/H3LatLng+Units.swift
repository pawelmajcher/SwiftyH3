
import Foundation

extension H3LatLng {
    var latitude: Measurement<UnitAngle> { Measurement(value: latitudeRads, unit: .radians) }
    var longitude: Measurement<UnitAngle> { Measurement(value: longitudeRads, unit: .radians) }

    var latitudeDegs: Double { self.latitude.converted(to: .degrees).value }
    var longitudeDegs: Double { self.longitude.converted(to: .degrees).value }
}

extension H3LatLng {
    init(latitudeDegs: Double, longitudeDegs: Double) {
        self.latitudeRads = Measurement<UnitAngle>(value: latitudeDegs, unit: .degrees).converted(to: .radians).value
        self.longitudeRads = Measurement<UnitAngle>(value: longitudeDegs, unit: .degrees).converted(to: .radians).value
    }
}