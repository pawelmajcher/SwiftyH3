
import Ch3

extension H3Polygon {
    init(from geoPolygon: Ch3.GeoPolygon) {
        let geoLoopHoles = Array<GeoLoop>(UnsafeBufferPointer(start: geoPolygon.holes, count: Int(geoPolygon.numHoles)))
        let holes = geoLoopHoles.map { loop in [H3LatLng](from: loop) }
        self = H3Polygon([H3LatLng](from: geoPolygon.geoloop), holes: holes)
    }

    func withGeoPolygon<R>(_ body: ((Ch3.GeoPolygon) throws -> R)) throws -> R {
        func withAllHoleGeoLoops<T>(
            holes: [[H3LatLng]],
            collected: [Ch3.GeoLoop] = [],
            _ body: ([Ch3.GeoLoop]) throws -> T
        ) throws -> T {
            if holes.isEmpty {
                return try body(collected)
            } else {
                var remainingHoles = holes
                let firstHole = remainingHoles.removeFirst()
                return try firstHole.withGeoLoop { newGeoLoop in
                    try withAllHoleGeoLoops(holes: remainingHoles, collected: collected + [newGeoLoop], body) 
                }
            }
        }

        return try self.boundary.withGeoLoop { boundaryLoop in
            try withAllHoleGeoLoops(holes: self.holes) { holeLoops in
                var mutableHoleLoops = holeLoops
                return try mutableHoleLoops.withUnsafeMutableBufferPointer { holeLoopsBuffer in
                    let geopolygon = Ch3.GeoPolygon(
                        geoloop: boundaryLoop,
                        numHoles: Int32(holeLoopsBuffer.count),
                        holes: holeLoopsBuffer.baseAddress
                    )

                    return try body(geopolygon)
                }
            }
        }
    }
}