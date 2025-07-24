
typealias H3Loop = [H3LatLng]

struct H3Polygon: Hashable {
    let boundary: H3Loop
    let holes: [H3Loop]
}

typealias H3MultiPolygon = [H3Polygon]