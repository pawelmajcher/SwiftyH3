
import Ch3

extension Ch3.LatLng {
    init(from h3latlng: H3LatLng) {
        self.init(lat: h3latlng.latitudeRads, lng: h3latlng.longitudeRads)
    }

    var h3LatLng: H3LatLng {
        H3LatLng(latitudeRads: self.lat, longitudeRads: self.lng)
    }
}

extension H3LatLng {
    init(from cLatLng: Ch3.LatLng) {
        self.init(latitudeRads: cLatLng.lat, longitudeRads: cLatLng.lng)
    }

    var cLatLng: Ch3.LatLng {
        Ch3.LatLng(from: self)
    }
}