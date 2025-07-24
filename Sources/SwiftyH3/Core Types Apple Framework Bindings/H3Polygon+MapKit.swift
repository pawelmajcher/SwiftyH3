
#if canImport(MapKit)

import MapKit

public extension MKPolygon {
    convenience init(from loop: H3Loop) {
        var coordinateLoop = loop.map { h3latlng in h3latlng.coordinates }
        self.init(coordinates: &coordinateLoop, count: loop.count)
    }
}

public extension MKPolygon {
    convenience init(from polygon: H3Polygon) {
        var boundaryCoordinateLoop = polygon.boundary.map { h3latlng in h3latlng.coordinates }
        let holePolygons = !polygon.holes.isEmpty ? polygon.holes.map { hole in MKPolygon(from: hole) } : nil

        self.init(coordinates: &boundaryCoordinateLoop, count: boundaryCoordinateLoop.count, interiorPolygons: holePolygons)
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public extension MKMultiPolygon {
    convenience init(from multipolygon: H3MultiPolygon) {
        let mkpolygons = multipolygon.map { polygon in MKPolygon(from: polygon) }
        self.init(mkpolygons)
    }
}

#endif