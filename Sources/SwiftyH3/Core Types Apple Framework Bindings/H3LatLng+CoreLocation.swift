
#if canImport(CoreLocation)

import CoreLocation

extension H3LatLng {
    init(from coordinates: CLLocationCoordinate2D) {
        self.init(latitudeDegs: coordinates.latitude, longitudeDegs: coordinates.longitude)
    }

    var coordinates: CLLocationCoordinate2D { CLLocationCoordinate2D(from: self) }
}

extension CLLocationCoordinate2D {
    init(from h3latlng: H3LatLng) {
        self.init(latitude: h3latlng.latitudeDegs, longitude: h3latlng.longitudeDegs)
    }

    var h3LatLng: H3LatLng { H3LatLng(from: self) }
}

#endif