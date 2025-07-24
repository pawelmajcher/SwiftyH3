
import Ch3

extension H3MultiPolygon {
    init(from geoMultiPolygon: Ch3.GeoMultiPolygon) {
        let geoPolygonArray = Array<GeoPolygon>(
            UnsafeBufferPointer(
                start: geoMultiPolygon.polygons,
                count: Int(geoMultiPolygon.numPolygons)
                )
            )
        
        self = geoPolygonArray.map { geopolygon in H3Polygon(from: geopolygon) }
    }
}