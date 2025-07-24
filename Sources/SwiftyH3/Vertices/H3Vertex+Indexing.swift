
import Ch3

public extension H3Vertex {
    var latLng: H3LatLng {
        get throws {
            guard self.isValid else { throw SwiftyH3Error.invalidInput }

            var cLatLng = Ch3.LatLng(lat: 0, lng: 0)
            let h3error = Ch3.vertexToLatLng(self.id, &cLatLng)

            guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }

            return H3LatLng(from: cLatLng)
        }
    }
}