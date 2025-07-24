
public typealias H3Loop = [H3LatLng]

public struct H3Polygon: Hashable, Sendable {
    let boundary: H3Loop
    let holes: [H3Loop]
}

public typealias H3MultiPolygon = [H3Polygon]