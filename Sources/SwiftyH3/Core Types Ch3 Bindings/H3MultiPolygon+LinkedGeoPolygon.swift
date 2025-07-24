
import Ch3

extension H3MultiPolygon {
    static func extract(from linkedPolygon: UnsafeMutablePointer<Ch3.LinkedGeoPolygon>) -> H3MultiPolygon {
        var polygons: [H3Polygon] = []
        var currentPolygon: Ch3.LinkedGeoPolygon? = linkedPolygon.pointee

        while let polygon = currentPolygon {
            let h3polygon = H3Polygon.extract(from: polygon.first)
            polygons.append(h3polygon)
            currentPolygon = polygon.next != nil ? polygon.next.pointee : nil
        }

        return polygons
    }
}