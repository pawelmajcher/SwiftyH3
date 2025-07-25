
public typealias H3Loop = [H3LatLng]

public struct H3Polygon: Hashable, Sendable {
    /// Polygon's boundary (exterior ring).
    public let boundary: H3Loop

    /// Polygon's holes (interior rings).
    public let holes: [H3Loop]

    public init(_ boundary: H3Loop, holes: [H3Loop] = []) {
        self.boundary = boundary
        self.holes = holes
    }
}

public typealias H3MultiPolygon = [H3Polygon]