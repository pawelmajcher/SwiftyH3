
#if canImport(CoreLocation)

import CoreLocation

public extension H3LatLng {
    init(_ coordinates: CLLocationCoordinate2D) {
        self.init(latitudeDegs: coordinates.latitude, longitudeDegs: coordinates.longitude)
    }

    var coordinates: CLLocationCoordinate2D { CLLocationCoordinate2D(self) }
}

public extension CLLocationCoordinate2D {
    init(_ h3latlng: H3LatLng) {
        self.init(latitude: h3latlng.latitudeDegs, longitude: h3latlng.longitudeDegs)
    }

    var h3LatLng: H3LatLng { H3LatLng(self) }
}

#endif