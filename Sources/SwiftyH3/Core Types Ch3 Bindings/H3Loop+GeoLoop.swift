
import Ch3

extension H3Loop {
    init(from geoLoop: Ch3.GeoLoop) {
        let indexArray = Array<LatLng>(UnsafeBufferPointer(start: geoLoop.verts, count: Int(geoLoop.numVerts)))
        self = indexArray.map { cLatLng in H3LatLng(from: cLatLng) }
    }

    func withGeoLoop<R>(_ body: ((Ch3.GeoLoop) throws -> R)) throws -> R {
        var cLatLngArray = self.map { point in point.cLatLng }
        return try cLatLngArray.withUnsafeMutableBufferPointer { buffer in
            let geoloop = Ch3.GeoLoop(numVerts: Int32(buffer.count), verts: buffer.baseAddress)
            return try body(geoloop)
        }
    }
}